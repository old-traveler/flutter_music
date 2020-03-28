import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/music.dart';
import 'package:music/entity/bean/lyric.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class LyricWidget extends StatefulWidget {
  final screenCount;

  LyricWidget({this.screenCount = 12});

  @override
  State<StatefulWidget> createState() => LyricState();
}

class LyricState extends State<LyricWidget> {
  static const double itemHeight = 40.0;
  String _songId;
  List<Lyric> lyricList;
  ScrollController controller;
  int _position = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        if (model.curSongInfo?.lyrics?.isEmpty != false) {
          return Center(
            child: Text(
              '暂无歌词',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }
        assert(model.curSongInfo != null);
        if (_songId != model.curSongInfo.hash) {
          lyricList = Lyric.formatLyric(model.curSongInfo.lyrics);
          lyricList.forEach((d) {
            print('歌词+ $d');
          });
        }
        return StreamBuilder<MusicState>(
          initialData: model.musicStateInfo,
          stream: model.progressChangeStream,
          builder: (context, data) {
            if (data.hasData) {
              final position =
                  Lyric.findLyricIndex(data.data.position, lyricList);
              if (_position != position) {
                _position = position;
                final offset = position * itemHeight;
                if (controller?.hasClients == true) {
                  controller.animateTo(offset,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                } else {
                  controller = ScrollController(initialScrollOffset: offset);
                }
              }
            }
            return Container(
              height: itemHeight * widget.screenCount,
              child: ListView.builder(
                controller: controller,
                padding: EdgeInsets.zero,
                itemBuilder: _buildLyricItem,
                itemCount: lyricList.length + widget.screenCount,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLyricItem(context, index) {
    if (index < widget.screenCount / 2 ||
        index >= lyricList.length + widget.screenCount / 2) {
      // 占位空行
      return Container(height: itemHeight);
    }
    int realIndex = index - widget.screenCount ~/ 2;
    return Container(
      height: itemHeight,
      alignment: Alignment.center,
      child: Text(
        lyricList[realIndex].lyric,
        style: TextStyle(
            color: realIndex == _position ? Colors.red : Colors.white,
            fontSize: 20),
      ),
    );
  }
}
