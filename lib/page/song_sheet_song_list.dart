import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/kg_song_sheet_list_entity.dart';
import 'package:music/http/http_manager.dart';

class SongSheetSongListPage extends StatefulWidget {
  final String specialId;
  final String title;

  const SongSheetSongListPage({Key key, this.specialId, this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      SongSheetSongListState(SongSheetSongListBloc());
}

class SongSheetSongListBloc with ResponseWorker, ListPageWorker {
  @override
  listResponseProvider() =>
      (page, offset) => HttpManager.getInstanceByUrl('http://m.kugou.com/')
          .get(getKgSongSheetList(widget.specialId, page));
}

class SongSheetSongListState
    extends BaseListState<KgSongSheetListEntity, SongSheetSongListPage> {
  SongSheetSongListState(ListPageWorker baseListBloc) : super(baseListBloc);

  @override
  Widget wrapContent(Widget contentWidget) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: contentWidget,
    );
  }

  @override
  void buildHeaderWidget(BuildContext context, KgSongSheetListEntity data) {
    addHeaderView('play_all_header', () {
      return Container(
        height: 40,
        color: Colors.white,
        child: _buildPlayAllHeader()
      );
    });
  }

  Widget _buildPlayAllHeader(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 15),
        Icon(Icons.play_circle_outline, color: Colors.black),
        SizedBox(width: 10),
        Text(
          '播放全部',
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }

  @override
  Widget buildItem(BuildContext context, data, int index) {
    final KgSongSheetListListListInfo itemData = data;
    final songInfo = itemData.filename.split(' - ');
    String singerName;
    String songName;
    if (songInfo.length == 2) {
      singerName = songInfo[0];
      songName = songInfo[1];
    } else {
      songName = itemData.filename;
      singerName = '未知歌手';
    }
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(songName),
        subtitle: Text(singerName),
      ),
    );
  }

  @override
  List getListData(KgSongSheetListEntity data) {
    return data?.xList?.xList?.info;
  }

  @override
  bool hasNextPage(KgSongSheetListEntity data) {
    final total = data?.xList?.xList?.total ?? 0;
    return total > max(0, (page - 1) * 30);
  }
}
