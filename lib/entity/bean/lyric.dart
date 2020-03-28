class Lyric {
  String lyric;
  Duration startTime;
  Duration endTime;
  double offset;

  Lyric(this.lyric, {this.startTime, this.endTime, this.offset});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }

  /// 格式化歌词
  static List<Lyric> formatLyric(String lyricStr) {
    /// 匹配[后面接两个数字的字符
    RegExp reg = RegExp(r"^\[\d{2}");

    List<Lyric> result =
        lyricStr.split("\n").where((r) => reg.hasMatch(r)).map((s) {
      String time = s.substring(0, s.indexOf(']'));
      String lyric = s.substring(s.indexOf(']') + 1);
      time = s.substring(1, time.length - 1);
      int minutesSeparatorIndex = time.indexOf(":");
      int secondsSeparatorIndex = time.indexOf(".");
      return Lyric(
        lyric,
        startTime: Duration(
          minutes: int.parse(
            time.substring(0, minutesSeparatorIndex),
          ),
          seconds: int.parse(
              time.substring(minutesSeparatorIndex + 1, secondsSeparatorIndex)),
          milliseconds: int.parse(time.substring(secondsSeparatorIndex + 1)),
        ),
      );
    }).toList();

    for (int i = 0; i < result.length - 1; i++) {
      result[i].endTime = result[i + 1].startTime;
    }
    result[result.length - 1].endTime = Duration(hours: 1);
    return result;
  }

  /// 查找歌词
  static int findLyricIndex(int curDuration, List<Lyric> lyrics) {
    for (int i = 0; i < lyrics.length; i++) {
      if (curDuration >= lyrics[i].startTime.inMilliseconds &&
          curDuration <= lyrics[i].endTime.inMilliseconds) {
        return i;
      }
    }
    return 0;
  }
}
