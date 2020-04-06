import 'dart:convert';

class MusicSongInfo {
  String hash;
  String playUrl;
  List<String> portrait;
  String albumId;
  String filename;
  String albumAudioId;
  String sizableCover;
  String songName;
  String singerName;
  String lyrics;
  int duration;

  MusicSongInfo(
      {this.hash,
      this.playUrl,
      this.portrait,
      this.albumId,
      this.filename,
      this.albumAudioId,
      this.sizableCover,
      this.songName,
      this.singerName,
      this.lyrics,
      this.duration = -1});

  @override
  bool operator ==(other) {
    if (other is MusicSongInfo) {
      return this.hash == other.hash;
    }
    return false;
  }

  @override
  int get hashCode => this.hash.hashCode;

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hash'] = this.hash;
    data['playUrl'] = this.playUrl;
    data['portrait'] = this.portrait;
    data['albumId'] = this.albumId;
    data['filename'] = this.filename;
    data['albumAudioId'] = this.albumAudioId;
    data['sizableCover'] = this.sizableCover;
    data['songName'] = this.songName;
    data['singerName'] = this.singerName;
    data['lyrics'] = this.lyrics;
    data['duration'] = this.duration;
    return json.encode(data);
  }

  MusicSongInfo.formJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    this.hash = data['hash'];
    this.playUrl = data['playUrl'];
    List<dynamic> list = data['portrait'];
    this.portrait = list?.map((data) => data.toString())?.toList();
    this.albumId = data['albumId'];
    this.filename = data['filename'];
    this.albumAudioId = data['albumAudioId'];
    this.sizableCover = data['sizableCover'];
    this.songName = data['songName'];
    this.singerName = data['singerName'];
    this.lyrics = data['lyrics'];
    this.duration = data['duration'];
  }
}
