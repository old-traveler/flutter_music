import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/music.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class MusicHomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MusicHomeState();
}

class MusicHomeState extends State<MusicHomeWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        if (model.curState == MusicStateType.STATE_PLAYING ||
            model.curState == MusicStateType.STATE_BUFFERING) {
          controller.forward();
        } else if (model.curState == MusicStateType.STATE_PAUSED ||
            model.curState == MusicStateType.STATE_STOPPED) {
          controller.stop();
        }
        return GestureDetector(
          child: model.curSongInfo == null
              ? Icon(Icons.music_note)
              : Container(
                  padding: EdgeInsets.all(6),
                  child: RotationTransition(
                    alignment: Alignment.center,
                    turns: controller,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundImage:
                          NetworkImage(model.curSongInfo.sizableCover),
                    ),
                  )),
          onTap: () {
            openMusicPlayPage(context);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
