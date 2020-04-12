import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/components/widget_img_menu.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';

import 'music_play_list_widget.dart';

class PlayBottomMenuWidget extends StatelessWidget {
  final PlaySongsModel model;

  PlayBottomMenuWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(200),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MusicModeButton(model),
          SizedBox(width: 25),
          BackgroundImageWidget(
            'images/icon_song_left.png',
            58,
            onTap: () {
              MusicWrapper.singleton.playPreviousSong();
            },
          ),
          BackgroundImageWidget(
            (model.curState != MusicStateType.STATE_PLAYING &&
                    model.curState != MusicStateType.STATE_BUFFERING)
                ? 'images/icon_song_play.png'
                : 'images/icon_song_pause.png',
            75,
            onTap: () {
              model.playOrPauseMusic();
            },
          ),
          BackgroundImageWidget(
            'images/icon_song_right.png',
            58,
            onTap: () {
              MusicWrapper.singleton.playNextSong();
            },
          ),
          SizedBox(width: 25),
          _buildPlayListButton(context)
        ],
      ),
    );
  }

  Widget _buildPlayListButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setWidth(90),
        child: GestureDetector(
          child: Image.asset(
            'images/icon_play_songs.png',
            fit: BoxFit.fitWidth,
          ),
          onTap: () {
            model.playListInfo
                .then((playList) => _showPlayList(context, playList));
          },
        ));
  }

  void _showPlayList(BuildContext context, List<MusicSongInfo> playList) {
    playList = playList.reversed.toList();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => MusicPlayListWidget(playList: playList));
  }
}

class MusicModeButton extends StatefulWidget {
  final PlaySongsModel model;
  static const playModeAsset = [
    'images/play_mode_order.png',
    'images/play_mode_single.png',
    'images/play_mode_randrom.png'
  ];

  const MusicModeButton(this.model);

  @override
  State<StatefulWidget> createState() => MusicModeState();
}

class MusicModeState extends State<MusicModeButton> {
  int curPlayMode = 0;

  @override
  void initState() {
    super.initState();
    curPlayMode = widget.model.curPlayMode;
  }

  @override
  Widget build(BuildContext context) {
    print('MusicModeState  ' + MusicModeButton.playModeAsset[curPlayMode]);
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      initialValue: curPlayMode,
      onSelected: (value) {
        if (value != curPlayMode) {
          widget.model.setPlayMode(value);
          if (!mounted) return;
          setState(() => (curPlayMode = value));
        }
      },
      color: Colors.black45,
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
        width: ScreenUtil().setWidth(90),
        height: ScreenUtil().setWidth(90),
        child: Image.asset(
          MusicModeButton.playModeAsset[curPlayMode],
          fit: BoxFit.fitWidth,
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: MusicPlayMode.REPEAT_MODE_NONE,
          child: ListTile(
            leading: Image.asset(
              MusicModeButton.playModeAsset[0],
              width: ScreenUtil().setWidth(50),
              fit: BoxFit.fitWidth,
            ),
            title: Text(
              "顺序播放",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: MusicPlayMode.REPEAT_MODE_ONE,
          child: ListTile(
            leading: Image.asset(
              MusicModeButton.playModeAsset[1],
              width: ScreenUtil().setWidth(50),
              fit: BoxFit.fitWidth,
            ),
            title: Text(
              "单曲循环",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: MusicPlayMode.REPEAT_MODE_ALL,
          child: ListTile(
            leading: Image.asset(
              MusicModeButton.playModeAsset[2],
              width: ScreenUtil().setWidth(50),
              fit: BoxFit.fitWidth,
            ),
            title: Text(
              "列表循环",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
