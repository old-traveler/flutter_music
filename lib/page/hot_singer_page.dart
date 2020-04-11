import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart' as api_url;
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/hot_singer_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/singer_song_list_page.dart';

/// 热门歌手页面
class HotSingerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotSingerState(HotSingerBloc());
}

class HotSingerBloc with ResponseWorker, ListPageWorker {
  @override
  listResponseProvider() => (page, offset) =>
      HttpManager.getInstanceByUrl('http://mobilecdnbj.kugou.com/')
          .get(api_url.singerUrl);
}

class HotSingerState extends BaseListState<HotSingerEntity, HotSingerPage> {
  HotSingerState(ListPageWorker baseListBloc) : super(baseListBloc);

  @override
  void buildHeaderWidget(BuildContext context, HotSingerEntity data) {
    if ((data?.data?.info?.isNotEmpty ?? false)) {
      addHeaderView('rank_header', () => _buildHeaderView(data.data.info[0]));
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildItem(BuildContext context, data, int index) {
    return _buildItemView(data, index);
  }

  @override
  List getListData(HotSingerEntity data) {
    return data?.data?.info;
  }

  @override
  bool hasNextPage(HotSingerEntity data) => false;

  Widget _buildHeaderView(HotSingerDataInfo firstData) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: firstData.imgurl.replaceFirst("{size}", '200'),
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
      color: Colors.white,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRanking(itemData, index + 1),
          Expanded(child: _buildSingerInfo(itemData))
        ],
      ),
    );
  }

  Widget _buildSingerInfo(HotSingerDataInfo itemData) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5, right: 15),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
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
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingerSongListPage(
                  singerId: itemData.singerid.toString(),
                  singerName: itemData.singername,
                )));
      },
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
}
