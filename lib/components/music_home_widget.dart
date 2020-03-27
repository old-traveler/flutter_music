import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class MusicHomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MusicHomeState();
}

class MusicHomeState extends State<MusicHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        return GestureDetector(
          child: model.curSongInfo == null
              ? Icon(Icons.music_note)
              : Container(
                  padding: EdgeInsets.all(6),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundImage:
                        NetworkImage(model.curSongInfo.sizableCover),
                  ),
                ),
          onTap: () {
            openMusicPlayPage(context);
          },
        );
      },
    );
  }
}
