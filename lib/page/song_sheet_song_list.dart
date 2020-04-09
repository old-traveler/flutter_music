import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/entity/kg_song_sheet_list_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

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
