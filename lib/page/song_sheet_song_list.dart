import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/components/BlurRectWidget.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/entity/kg_song_sheet_list_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class SongSheetSongListPage extends StatefulWidget {
  final String specialId;
  final String title;
  final String imageUrl;
  final String intro;
  final String username;
  final String userAvatar;

  const SongSheetSongListPage(
      {Key key,
      this.specialId,
      this.title,
      this.imageUrl,
      this.intro,
      this.userAvatar,
      this.username})
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
  SongSheetSongListState(ListPageWorker baseListBloc)
      : super(baseListBloc, listConfig: ListConfig(enablePullDown: false));

  @override
  Widget wrapContent(Widget contentWidget) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: _sliverBuilder, body: contentWidget));
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
          //标题居中
          expandedHeight: 250.0,
          floating: false,
          //不随着滑动隐藏标题
          pinned: true,
          forceElevated: innerBoxIsScrolled,
          title: Text(widget.title),
          //固定在顶部
          flexibleSpace: _flexibleSpace()),
    ];
  }

  Widget _flexibleSpace() {
    return FlexibleSpaceBar(
        background: Stack(
      children: <Widget>[
        Image.network(
          widget.imageUrl,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
        BlurRectWidget(
          child: Container(),
        ),
        Positioned(bottom: 20, child: _spaceContent())
      ],
    ));
  }

  Widget _spaceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _userInfoWidget(),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            widget.intro,
            style: TextStyle(color: Colors.white),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _userInfoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        CircleAvatar(
          radius: 14.0,
          backgroundImage: NetworkImage(widget.userAvatar, scale: 2),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.username,
          style: TextStyle(color: Color(0xffD7AF77), fontSize: 15),
        )
      ],
    );
  }

  @override
  void buildHeaderWidget(BuildContext context, KgSongSheetListEntity data) {
    addHeaderView('play_all_header', () {
      return Container(
          height: 40,
          color: Colors.white,
          child: GestureDetector(
            child: _buildPlayAllHeader(),
            onTap: _onPlayAllButtonTap,
          ));
    });
  }

  Widget _buildPlayAllHeader() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 15),
        Icon(Icons.play_circle_outline, color: Colors.black),
        SizedBox(width: 10),
        Text('播放全部', style: TextStyle(color: Colors.black)),
      ],
    );
  }

  void _onPlayAllButtonTap() {
    final List<MusicSongInfo> list =
        dataList.map((data) => toMusicSongInfo(data)).toList();
    Provider.of<PlaySongsModel>(context, listen: false)
        .playSongList(info: list, index: 0);
  }

  @override
  Widget buildItem(BuildContext context, data, int index) {
    final KgSongSheetListListListInfo itemData = data;
    final nameInfo = decodeName(itemData);
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(nameInfo.value),
        subtitle: Text(nameInfo.key),
        onTap: () => openMusicPlayPage(itemData),
      ),
    );
  }

  void openMusicPlayPage(KgSongSheetListListListInfo itemData) {
    openMusicByMusicSongInfo(
        context: context, musicSongInfo: toMusicSongInfo(itemData));
  }

  MusicSongInfo toMusicSongInfo(KgSongSheetListListListInfo itemData) {
    final nameInfo = decodeName(itemData);
    return MusicSongInfo(
        hash: itemData.hash,
        albumId: itemData.albumId,
        filename: itemData.filename,
        albumAudioId: itemData.albumAudioId.toString(),
        sizableCover: "",
        singerName: nameInfo.key,
        songName: nameInfo.value,
        lyrics: "",
        duration: -1);
  }

  MapEntry<String, String> decodeName(KgSongSheetListListListInfo itemData) {
    String singerName;
    String songName;
    final songInfo = itemData.filename.split(' - ');
    if (songInfo.length == 2) {
      singerName = songInfo[0];
      songName = songInfo[1];
    } else {
      songName = itemData.filename;
      singerName = '未知歌手';
    }
    return MapEntry<String, String>(singerName, songName);
  }

  @override
  List getListData(KgSongSheetListEntity data) {
    return data?.xList?.xList?.info;
  }

  @override
  bool hasNextPage(KgSongSheetListEntity data) {
    final total = data?.xList?.xList?.total ?? 0;
    return total > itemCount;
  }
}
