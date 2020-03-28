import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/entity/bean/lyric.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class LyricWidget extends StatefulWidget {
  final screenCount;

  LyricWidget({this.screenCount = 10});

  @override
  State<StatefulWidget> createState() => LyricState();
}

class LyricState extends State<LyricWidget> {
  static const double itemHeight = 50.0;
  String _songId;
  List<Lyric> lyricList;

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
        }
        return Container(
          height: itemHeight * widget.screenCount,
          child: ListView.builder(
            itemBuilder: _buildLyricItem,
            itemCount: lyricList.length + widget.screenCount,
          ),
        );
      },
    );
  }

  Widget _buildLyricItem(context, index) {
    if (index < widget.screenCount / 2 ||
        index >= lyricList.length + widget.screenCount / 2) {
      // 占位空行
      return SizedBox(height: itemHeight);
    }
    int realIndex = index - widget.screenCount ~/ 2;
    return Container(
      height: itemHeight,
      alignment: Alignment.center,
      child: Text(lyricList[realIndex].lyric,style: TextStyle(color: Colors.white, fontSize: 18),),
    );
  }
}
