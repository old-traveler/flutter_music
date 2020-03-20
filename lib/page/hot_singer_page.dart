import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart' as api_url;
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/hot_singer_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

/// 热门歌手页面
class HotSingerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotSingerState();
}

class HotSingerBloc extends BaseBloc {
  void _fetchHotSingerData() {
    dealResponse<HotSingerEntity>(
        responseProvider: () =>
            HttpManager.getInstanceByUrl('http://mobilecdnbj.kugou.com/')
                .get(api_url.singerUrl));
  }
}

class HotSingerState extends State<HotSingerPage> with AutomaticKeepAliveClientMixin{
  HotSingerBloc _hotSingerBloc = HotSingerBloc();

  @override
  void initState() {
    super.initState();
    _hotSingerBloc._fetchHotSingerData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InheritedProvider.value(
      value: _hotSingerBloc.streamManager,
      updateShouldNotify: (o, n) => false,
      child: smartStreamBuilder2<HotSingerEntity>(
        streamManager: _hotSingerBloc.streamManager,
        builder: (context, data) => ListView.builder(
          itemBuilder: (context, index) => index == 0
              ? _buildHeaderView(data.data.info[0])
              : _buildItemView(data.data.info[index - 1], index - 1),
          itemCount: (data?.data?.info?.length ?? 0) + 1,
        ),
      ),
    );
  }

  Widget _buildHeaderView(HotSingerDataInfo firstData) {
    return Stack(
      children: <Widget>[
        Image.network(
          firstData.imgurl.replaceFirst("{size}", '200'),
          height: 270,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: 15,
          bottom: 40,
          child: Text(
            'NO.1 ${firstData.singername}',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 15,
          child: Text('恭喜占领本期榜单封面',
              style: TextStyle(fontSize: 14, color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildItemView(HotSingerDataInfo itemData, int index) {
    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRanking(itemData, index + 1),
          Expanded(
            child: ListTile(
                contentPadding: EdgeInsets.only(left: 5, right: 15),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    itemData.imgurl.replaceFirst('{size}', '100'),
                  ),
                ),
                title: Text(
                  itemData.singername,
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text('${itemData.heat}热度'),
                trailing: SizedBox(
                  height: 25,
                  width: 60,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      '关注',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildRanking(HotSingerDataInfo itemData, int index) {
    final list = <Widget>[];
    list.add(index <= 3
        ? Image.asset(
            'images/rank$index.png',
            width: 25,
            fit: BoxFit.fitWidth,
          )
        : Text(index.toString()));
    list.add(SizedBox(
      height: 3,
    ));
    Color changeColor = Colors.black;
    String change = itemData.heatoffset.toString();
    if (itemData.heatoffset > 0) {
      change = '+ ${itemData.heatoffset}';
      changeColor = Colors.green;
    } else if (itemData.heatoffset == 0) {
      change = '—';
    } else {
      change = '- ${itemData.heatoffset.abs()}';
      changeColor = Colors.red;
    }
    list.add(Text(
      change,
      style: TextStyle(fontSize: 9, color: changeColor),
    ));
    return Container(
      width: 45,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: list),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
