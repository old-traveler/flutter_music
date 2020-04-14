import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/entity/bean/lyric.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/date_util.dart';
import 'package:provider/provider.dart';
import 'package:music/util/size_extension.dart';

class LyricWidget extends StatefulWidget {
  final screenCount;

  LyricWidget({this.screenCount = 13});

  @override
  State<StatefulWidget> createState() => LyricState();
}

class LyricState extends State<LyricWidget> {
  static double itemHeight = 100.0.h;
  String _songId;
  List<Lyric> lyricList;
  ScrollController controller;
  int _position = 0;
  bool isMove = false;
  Timer dragEndTimer; // 拖动结束任务
  int preSelectPosition = -1;
  Duration curTimeBarDuration = Duration(milliseconds: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        if (model.curSongInfo?.lyrics?.isEmpty != false) {
          return _buildNoLyricWidget();
        }
        assert(model.curSongInfo != null);
        if (_songId != model.curSongInfo.hash) {
          _songId = model.curSongInfo.hash;
          lyricList = Lyric.formatLyric(model.curSongInfo.lyrics);
          isMove = false;
          dragEndTimer?.cancel();
          dragEndTimer = null;
          preSelectPosition = -1;
        }
        return StreamBuilder<MusicState>(
          initialData: model.musicStateInfo,
          stream: model.progressChangeStream,
          builder: (context, data) {
            if (data.hasData) {
              computePosition(data.data.position);
            }
            return _buildLyricList();
          },
        );
      },
    );
  }

  Widget _buildNoLyricWidget() {
    return Center(
      child: Text(
        '暂无歌词',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildLyricList() {
    final child = Listener(
        onPointerUp: (event) => recoverMoveState(),
        onPointerCancel: (event) => recoverMoveState(),
        onPointerDown: (event) {
          preSelectPosition = -1;
          dragEndTimer?.cancel();
        },
        onPointerMove: (event) => _onSliverLyric(),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              controller: controller,
              padding: EdgeInsets.zero,
              itemBuilder: _buildLyricItem,
              itemCount: lyricList.length + widget.screenCount - 1,
            ),
            _buildLyricTimeBar()
          ],
        ));
    return Container(height: itemHeight * widget.screenCount, child: child);
  }

  void _onSliverLyric() {
    isMove = true;
    int curPosition = (controller.offset + itemHeight ~/ 2) ~/ itemHeight;
    if (curPosition != preSelectPosition) {
      curTimeBarDuration = lyricList[curPosition].startTime;
      preSelectPosition = curPosition;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _buildLyricTimeBar() {
    Widget child;
    if (isMove) {
      child = Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 28,
            ),
            onTap: () {
              MusicWrapper.singleton.seekTo(curTimeBarDuration.inMilliseconds);
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              height: 1,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Text(
            DateUtil.formatDateMs(curTimeBarDuration.inMilliseconds,
                format: "mm:ss"),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(width: 10)
        ],
      );
    }
    return Container(alignment: Alignment.center, child: child);
  }

  void recoverMoveState() {
    dragEndTimer?.cancel();
    dragEndTimer = null;
    dragEndTimer = Timer(const Duration(milliseconds: 2000), () {
      if (isMove && mounted) {
        setState(() => isMove = false);
      }
    });
  }

  /// 计算当前中心歌词位置
  void computePosition(int curDuration) {
    final position = Lyric.findLyricIndex(curDuration, lyricList);
    if (_position != position) {
      _position = position;
      final offset = position * itemHeight;
      if (controller?.hasClients == true) {
        if (isMove) return;
        controller.animateTo(offset,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      } else {
        controller = ScrollController(initialScrollOffset: offset);
      }
    }
  }

  Widget _buildLyricItem(context, index) {
    if (index < widget.screenCount ~/ 2 ||
        index >= lyricList.length + widget.screenCount ~/ 2) {
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
            color: realIndex == _position ? Color(0xFFEEE581) : Colors.white,
            fontSize: 18),
      ),
    );
  }
}
