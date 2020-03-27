import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        controller.forward();
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
