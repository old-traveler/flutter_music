import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class SingerPortraitEntity with JsonConvert<SingerPortraitEntity> {
  int status;
  @JSONField(name: "error_code")
  int errorCode;
  List<SingerPortraitData> data;
}

class SingerPortraitData with JsonConvert<SingerPortraitData> {
  List<SingerPortraitDataAlbum> album;
  List<SingerPortraitDataAuthor> author;
}

class SingerPortraitDataAlbum with JsonConvert<SingerPortraitDataAlbum> {
  @JSONField(name: "album_name")
  String albumName;
  @JSONField(name: "album_id")
  int albumId;
  SingerPortraitDataAlbumImgs imgs;
  @JSONField(name: "sizable_cover")
  String sizableCover;
  int category;
}

class SingerPortraitDataAlbumImgs
    with JsonConvert<SingerPortraitDataAlbumImgs> {}

class SingerPortraitDataAuthor with JsonConvert<SingerPortraitDataAuthor> {
  SingerPortraitDataAuthorImgs imgs;
  @JSONField(name: "author_id")
  int authorId;
  @JSONField(name: "sizable_avatar")
  String sizableAvatar;
  @JSONField(name: "author_name")
  String authorName;
}

class SingerPortraitDataAuthorImgs
    with JsonConvert<SingerPortraitDataAuthorImgs> {
  @JSONField(name: "4")
  List<SingerPortraitDataAuthorImgs4> imageList;
}

class SingerPortraitDataAuthorImgs4
    with JsonConvert<SingerPortraitDataAuthorImgs4> {
  @JSONField(name: "sizable_portrait")
  String sizablePortrait;
  @JSONField(name: "file_hash")
  String fileHash;
}
