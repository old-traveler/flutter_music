import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        if (model.curState == MusicStateType.STATE_PLAYING ||
            model.curState == MusicStateType.STATE_BUFFERING) {
          controller.repeat();
        } else if (model.curState == MusicStateType.STATE_PAUSED ||
            model.curState == MusicStateType.STATE_STOPPED) {
          controller.stop();
        }
        return _buildContent(model);
      },
    );
  }

  Widget _buildContent(PlaySongsModel model) {
    return GestureDetector(
      onTap: () {
        openMusicPlayPage(context);
      },
      child: model.curSongInfo == null
          ? Icon(Icons.music_note)
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildProgress(model),
                _buildAvatar(model),
              ],
            ),
    );
  }

  Widget _buildProgress(PlaySongsModel model) {
    return Container(
      height: 43,
      width: 43,
      child: StreamBuilder<MusicState>(
        stream: model.progressChangeStream,
        builder: (context, data) {
          final state = data.data;
          double value =
              state == null ? 0 : state.position * 1.0 / state.duration;
          if (value.isNaN) {
            value = 1.0;
          }
          value = max(0.0, min(1.0, value));
          return CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.white70,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            value: value,
          );
        },
      ),
    );
  }

  Widget _buildAvatar(PlaySongsModel model) {
    return Positioned(
      child: Container(
          child: RotationTransition(
        alignment: Alignment.center,
        turns: controller,
        child: CircleAvatar(
          radius: 21,
          backgroundImage:
              CachedNetworkImageProvider(model.curSongInfo.sizableCover),
        ),
      )),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    controller?.stop();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
