import 'dart:math';

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
        AnimationController(duration: const Duration(seconds: 15), vsync: this);
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
              : Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 43,
                      width: 43,
                      child: StreamBuilder<MusicState>(
                        stream: model.progressChangeStream,
                        builder: (context, data) {
                          final state = data.data;
                          double value = state == null
                              ? 0
                              : state.position * 1.0 / state.duration;
                          value = max(0.0, min(1.0, value));
                          return CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor: Colors.white70,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            value: value,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      child: Container(
                          child: RotationTransition(
                        alignment: Alignment.center,
                        turns: controller,
                        child: CircleAvatar(
                          radius: 21,
                          backgroundImage:
                              NetworkImage(model.curSongInfo.sizableCover),
                        ),
                      )),
                    )
                  ],
                ),
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
