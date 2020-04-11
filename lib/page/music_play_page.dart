import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/components/lyric_widget.dart';
import 'package:music/components/music_background_widget.dart';
import 'package:music/components/widget_play_bottom_menu.dart';
import 'package:music/components/widget_song_progress.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';
import 'package:music/util/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

// ignore: sdk_version_extension_methods
extension SongName on String {
  String noTag() {
    return this.replaceAll("<em>", "").replaceAll("</em>", "");
  }
}

void openMusicPlayPageByInfo(
    {BuildContext context,
    String songId,
    String albumId,
    String filename,
    String albumAudioId,
    String songName,
      String authorId,
    String singerName}) {
  final MusicSongInfo musicSongInfo = MusicSongInfo(
      hash: songId,
      albumId: albumId,
      filename: filename.noTag(),
      albumAudioId: albumAudioId,
      sizableCover: "",
      songName: songName.noTag(),
      singerName: singerName,
      lyrics: "",
      authorId: authorId,
      duration: -1);
  openMusicByMusicSongInfo(context: context, musicSongInfo: musicSongInfo);
}

openMusicByMusicSongInfo({BuildContext context, MusicSongInfo musicSongInfo}) {
  final model = Provider.of<PlaySongsModel>(context, listen: false);
  if (!model.playSongById(musicSongInfo.hash)) {
    model.playSong(musicSongInfo);
  }
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => MusicPlayPage()));
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
        statusBarIconBrightness: Brightness.light));
    return Consumer<PlaySongsModel>(builder: (context, value, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(value),
          body: _buildBody(value));
    });
  }

  Widget _buildAppBar(PlaySongsModel value) {
    return AppBar(
      centerTitle: true,
      title: Text(value.curSongInfo?.songName ?? '暂无歌曲'),
      brightness: Brightness.dark,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        GestureDetector(
          child: Image.asset(
            'images/download.png',
            width: 35,
            fit: BoxFit.fitWidth,
          ),
          onTap: () {
            if (value.curSongInfo == null) return;
            MusicWrapper.singleton.downloadMusic(
                '${value.curSongInfo.songName}-${value.curSongInfo.singerName}');
          },
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          child: Image.asset(
            'images/share.png',
            width: 35,
            fit: BoxFit.fitWidth,
          ),
          onTap: () {
            Share.share('给你分享了一首歌曲：${value.curSongInfo?.playUrl ?? ""}');
          },
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  Widget _buildBody(PlaySongsModel value) {
    return Stack(
      children: <Widget>[
        MusicBackgroundWidget(),
        Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              LyricWidget(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
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
    );
  }
}
