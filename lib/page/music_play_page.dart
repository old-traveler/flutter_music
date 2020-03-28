import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/api/api_url.dart';
import 'package:music/components/music_background_widget.dart';
import 'package:music/components/widget_play_bottom_menu.dart';
import 'package:music/components/widget_song_progress.dart';
import 'package:music/entity/search_song_entity.dart';
import 'package:music/entity/song_play_entity.dart';
import 'package:music/generated/json/song_play_entity_helper.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';
import 'package:music/util/toast_util.dart';
import 'package:provider/provider.dart';

// ignore: sdk_version_extension_methods
extension SongName on String {
  String noTag() {
    return this.replaceAll("<em>", "").replaceAll("</em>", "");
  }
}

Future openMusicPlayPageByInfo(
    BuildContext context, SearchSongDataInfo info) async {
  final model = Provider.of<PlaySongsModel>(context, listen: false);
  if (model.playSongById(info.hash)) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MusicPlayPage()));
    return;
  }
  Response response =
      await HttpManager.getInstanceByUrl('https://wwwapi.kugou.com/')
          .get(getSongUrl(info.hash));
  print("https://wwwapi.kugou.com/" + getSongUrl(info.hash));
  print(response.toString());
  if (response == null) {
    ToastUtil.show(context: context, msg: '网络不给力');
    return;
  }
  SongPlayEntity entity = songPlayEntityFromJson(
      SongPlayEntity(), json.decode(response.toString()));
  if (entity.status == 1 && (entity?.data?.playUrl?.isNotEmpty == true)) {
    final MusicSongInfo musicSongInfo = MusicSongInfo(
        hash: info.hash,
        playUrl: entity.data.playUrl,
        albumId: info.albumId,
        filename: info.filename.noTag(),
        albumAudioId: info.albumAudioId.toString(),
        sizableCover:
            entity.data.authors[0].sizableAvatar.replaceFirst('{size}', '100'),
        songName: info.songname.noTag(),
        singerName: info.singername,
        lyrics: entity.data.lyrics);
    model.playSong(musicSongInfo);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MusicPlayPage()));
  } else {
    ToastUtil.show(context: context, msg: '加载失败');
  }
}

openMusicPlayPage(BuildContext context, {PlaySongsModel model}) {
  model ??= Provider.of<PlaySongsModel>(context, listen: false);
  if (model.curSongInfo != null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MusicPlayPage()));
  } else {
    ToastUtil.show(context: context, msg: '请先选择音乐');
  }
}

class MusicPlayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MusicPlayState();
}

class MusicPlayState extends State<MusicPlayPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Consumer<PlaySongsModel>(builder: (context, value, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(value.curSongInfo?.songName ?? '暂无歌曲'),
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              MusicBackgroundWidget(),
              Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text('内容'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: SongProgressWidget(value),
                    ),
                    PlayBottomMenuWidget(value),
                    SizedBox(
                      height: ScreenUtil().setWidth(40),
                    )
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
