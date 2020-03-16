import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/live_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LivePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LivePageState();
  }
}

class LiveBloc extends BaseBloc {
  final LivePageState _livePageState;
  int _page = 1;

  LiveBloc(this._livePageState);

  void fetchListData(bool isRefresh) {
    if (isRefresh) _page = 1;
    print("page:$_page");
    dealResponse<LiveEntity>(
        responseProvider: () {
          return HttpManager.getInstanceByUrl(keGouBaseUrl)
              .get(getLiveUrl(page: _page));
        },
        needLoading: isRefresh,
        stopLoading: (isOk) {
          print("调用stopLoading$isOk");
          if (_page == 1) {
            _livePageState._refreshController.refreshCompleted();
          } else {
            _livePageState._refreshController.loadComplete();
          }
          if (isOk) {
            _page++;
          }
        });
  }
}

class LivePageState extends State<LivePage> {
  LiveBloc _liveBloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    this._liveBloc = LiveBloc(this);
    _onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    _liveBloc.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    return smartStreamBuilder2<LiveEntity>(
        streamManager: _liveBloc.streamManager,
        isNoData: (data) => (data?.data?.xList?.isEmpty ?? true),
        builder: (context, data) {
          data.data.xList.removeWhere((item) =>
              (item.imgPath?.isEmpty ?? true) || (item.label?.isEmpty ?? true));
          print("构建");
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: ClassicHeader(),
              footer: ClassicFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.2),
                itemBuilder: (context, index) {
                  final itemData = data.data.xList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          itemData.imgPath.contains("http")
                              ? itemData.imgPath
                              : itemData.userLogo,
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          height: (MediaQuery.of(context).size.width / 2 - 10) *
                              0.75,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            itemData.label ?? "null",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: data.data.xList.length ?? 0,
              ));
        });
  }

  void _onRefresh() {
    _liveBloc.fetchListData(true);
  }

  void _onLoading() {
    _liveBloc.fetchListData(false);
  }
}
