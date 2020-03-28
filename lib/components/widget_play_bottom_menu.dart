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
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageMenuWidget('images/icon_song_play_type_1.png', 90),
          SizedBox(
            width: 40,
          ),
          BackgroundImageWidget(
            'images/icon_song_left.png',
            40,
            onTap: () {
              MusicWrapper.singleton.playPreviousSong();
            },
          ),
          BackgroundImageWidget(
            model.curState != MusicStateType.STATE_PLAYING
                ? 'images/icon_song_play.png'
                : 'images/icon_song_pause.png',
            70,
            onTap: () {
              MusicWrapper.singleton.playOrPauseMusic();
            },
          ),
          BackgroundImageWidget(
            'images/icon_song_right.png',
            40,
            onTap: () {
              MusicWrapper.singleton.playNextSong();
            },
          ),
          SizedBox(
            width: 40,
          ),
          ImageMenuWidget('images/icon_play_songs.png', 90),
        ],
      ),
    );
  }
}
