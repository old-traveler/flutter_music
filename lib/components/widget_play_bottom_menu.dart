import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/music.dart';
import 'package:music/components/widget_img_menu.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';

class PlayBottomMenuWidget extends StatelessWidget {

  final PlaySongsModel model;

  PlayBottomMenuWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(150),
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          ImageMenuWidget('images/icon_song_play_type_1.png', 80),
          ImageMenuWidget(
            'images/icon_song_left.png',
            80,
            onTap: () {
              MusicWrapper.singleton.playPreviousSong();
            },
          ),
          ImageMenuWidget(
            model.curState != MusicStateType.STATE_PLAYING
                ? 'images/icon_song_play.png'
                : 'images/icon_song_pause.png',
            150,
            onTap: () {
              MusicWrapper.singleton.playOrPauseMusic();
            },
          ),
          ImageMenuWidget(
            'images/icon_song_right.png',
            80,
            onTap: () {
              MusicWrapper.singleton.playNextSong();
            },
          ),
          ImageMenuWidget('images/icon_play_songs.png', 80),
        ],
      ),
    );
  }
}


