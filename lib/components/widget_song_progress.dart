import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/music.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/date_util.dart';
import 'package:music/util/screenutil.dart';

class SongProgressWidget extends StatelessWidget {
  final PlaySongsModel model;

  SongProgressWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MusicState>(
      stream: model.progressChangeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          var totalTime = state.duration.toDouble();
          var curTime = state.position.toDouble();
          var curTimeStr =
              DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
          return buildProgress(curTime, totalTime, curTimeStr);
        } else {
          return buildProgress(0, 0, "00:00");
        }
      },
    );
  }

  Widget buildProgress(double curTime, double totalTime, String curTimeStr) {
    return Container(
      height: ScreenUtil().setWidth(50),
      child: Row(
        children: <Widget>[
          Text(
            curTimeStr,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: ScreenUtil().setWidth(2),
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: ScreenUtil().setWidth(10),
                ),
              ),
              child: Slider(
                value: curTime,
                onChanged: (data) {
                  model.seekToProgress(data.toInt());
                },
                onChangeStart: (data) {
                  model.sinkProgress = false;
                },
                onChangeEnd: (data) {
                  MusicWrapper.singleton.seekTo(data.toInt());
                  model.sinkProgress = true;
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                min: 0,
                max: totalTime,
              ),
            ),
          ),
          Text(
            DateUtil.formatDateMs(totalTime.toInt(), format: "mm:ss"),
            style: TextStyle(fontSize: 12, color: Colors.white30),
          ),
        ],
      ),
    );
  }
}
