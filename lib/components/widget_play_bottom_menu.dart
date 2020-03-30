import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/components/widget_img_menu.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';

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
          ImageMenuWidget('images/icon_song_play_type_1.png', 90),
          SizedBox(
            width: 25,
          ),
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
              MusicWrapper.singleton.playOrPauseMusic();
            },
          ),
          BackgroundImageWidget(
            'images/icon_song_right.png',
            58,
            onTap: () {
              MusicWrapper.singleton.playNextSong();
            },
          ),
          SizedBox(
            width: 25,
          ),
          ImageMenuWidget(
            'images/icon_play_songs.png',
            90,
            onTap: () {
              model.playListInfo
                  .then((playList) => _showPlayList(context, playList));
            },
          ),
        ],
      ),
    );
  }

  void _showPlayList(BuildContext context, List<MusicSongInfo> playList) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            builder: (context, controller) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // build header
                    return Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '播放列表',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (index == 1) {
                    // build Divider
                    return Divider(
                      height: 1,
                    );
                  }
                  final itemData = playList[index - 2];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(itemData.sizableCover),
                    ),
                    title: Text(itemData.songName),
                    subtitle: Text(itemData.singerName),
                    trailing: Icon(Icons.more_horiz),
                  );
                },
                itemCount: (playList?.length ?? 0) + 2,
              );
            },
          );
        });
  }
}
