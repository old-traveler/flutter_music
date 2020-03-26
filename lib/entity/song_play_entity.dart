import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class SongPlayEntity with JsonConvert<SongPlayEntity> {
	int status;
	@JSONField(name: "err_code")
	int errCode;
	SongPlayData data;
}

class SongPlayData with JsonConvert<SongPlayData> {
	String hash;
	int timelength;
	int filesize;
	@JSONField(name: "audio_name")
	String audioName;
	@JSONField(name: "have_album")
	int haveAlbum;
	@JSONField(name: "album_name")
	String albumName;
	@JSONField(name: "album_id")
	String albumId;
	String img;
	@JSONField(name: "have_mv")
	int haveMv;
	@JSONField(name: "video_id")
	int videoId;
	@JSONField(name: "author_name")
	String authorName;
	@JSONField(name: "song_name")
	String songName;
	String lyrics;
	@JSONField(name: "author_id")
	String authorId;
	int privilege;
	String privilege2;
	@JSONField(name: "play_url")
	String playUrl;
	List<SongPlayDataAuthor> authors;
	@JSONField(name: "is_free_part")
	int isFreePart;
	int bitrate;
	@JSONField(name: "audio_id")
	String audioId;
	@JSONField(name: "play_backup_url")
	String playBackupUrl;
}

class SongPlayDataAuthor with JsonConvert<SongPlayDataAuthor> {
	@JSONField(name: "author_id")
	String authorId;
	@JSONField(name: "is_publish")
	String isPublish;
	@JSONField(name: "sizable_avatar")
	String sizableAvatar;
	@JSONField(name: "author_name")
	String authorName;
	String avatar;
}


