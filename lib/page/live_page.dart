import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/live_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/web_page.dart';
import 'package:music/util/color_util.dart';

class LivePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LivePageState(LiveBloc());
}

class LiveBloc with ResponseWorker, ListPageWorker {
  @override
  ListResponseProvider listResponseProvider() => (page, offset) =>
      HttpManager.getInstanceByUrl(keGouBaseUrl).get(getLiveUrl(page: page));
}

class LivePageState extends BaseListState<LiveEntity, LivePage> {
  LivePageState(ListPageWorker baseListBloc) : super(baseListBloc);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildItem(BuildContext context, dynamic data, int index) {
    final LiveDataList itemData = data;
    return GestureDetector(
        child: _buildItemWidget(data),
        onTap: () => openWebPage(
            context, 'https://fanxing.kugou.com/${itemData.roomId}'));
  }

  @override
  List getListData(LiveEntity data) {
    data?.data?.xList?.removeWhere((item) =>
        (item.imgPath?.isEmpty ?? true) || (item.label?.isEmpty ?? true));
    return data?.data?.xList;
  }

  @override
  bool hasNextPage(data) {
    return !(data?.data?.hasNextPage == 0);
  }

  @override
  Widget buildListView(LiveEntity data, int itemAndHeaderCount) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.18),
      itemBuilder: (context, index) => itemBuilder(context, index),
      itemCount: itemAndHeaderCount,
    );
  }

  Widget _buildItemWidget(LiveDataList itemData) {
    final widgets = <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _buildLiveInfo(itemData)),
      Expanded(
        child: Center(
          child: Text(
            itemData.label ?? "null",
            style: TextStyle(fontSize: 15),
          ),
        ),
      )
    ];
    return Column(
      children: widgets,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildLiveInfo(LiveDataList itemData) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: itemData.imgPath.contains("http")
              ? itemData.imgPath
              : itemData.userLogo,
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: (MediaQuery.of(context).size.width / 2 - 10) * 0.75,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 10,
          bottom: 3,
          child: Text(
            itemData.nickName,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Positioned(
            right: 10,
            bottom: 3,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '${itemData?.viewerNum ?? 1}万',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )),
        _buildTagWidget(itemData.tags)
      ],
    );
  }

  Widget _buildTagWidget(List<LiveDataListTag> tags) {
    if (tags?.isEmpty ?? true) {
      return SizedBox();
    }
    final tag = tags[0];
    if (tag?.tagUrl?.isNotEmpty ?? false) {
      return CachedNetworkImage(
        imageUrl: tag.tagUrl,
        height: 20,
        fit: BoxFit.fitHeight,
      );
    }
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      decoration: BoxDecoration(
          color: parseColor(tag.tagColor),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0))),
      child: Text(
        tag.tagName,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
