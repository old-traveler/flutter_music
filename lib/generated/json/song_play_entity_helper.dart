import 'package:music/entity/song_play_entity.dart';

songPlayEntityFromJson(SongPlayEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['err_code'] != null) {
		data.errCode = json['err_code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new SongPlayData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> songPlayEntityToJson(SongPlayEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['err_code'] = entity.errCode;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

songPlayDataFromJson(SongPlayData data, Map<String, dynamic> json) {
	if (json['hash'] != null) {
		data.hash = json['hash']?.toString();
	}
	if (json['timelength'] != null) {
		data.timelength = json['timelength']?.toInt();
	}
	if (json['filesize'] != null) {
		data.filesize = json['filesize']?.toInt();
	}
	if (json['audio_name'] != null) {
		data.audioName = json['audio_name']?.toString();
	}
	if (json['have_album'] != null) {
		data.haveAlbum = json['have_album']?.toInt();
	}
	if (json['album_name'] != null) {
		data.albumName = json['album_name']?.toString();
	}
	if (json['album_id'] != null) {
		data.albumId = json['album_id']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['have_mv'] != null) {
		data.haveMv = json['have_mv']?.toInt();
	}
	if (json['video_id'] != null) {
		data.videoId = int.parse(json['video_id'].toString());
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	if (json['song_name'] != null) {
		data.songName = json['song_name']?.toString();
	}
	if (json['lyrics'] != null) {
		data.lyrics = json['lyrics']?.toString();
	}
	if (json['author_id'] != null) {
		data.authorId = json['author_id']?.toString();
	}
	if (json['privilege'] != null) {
		data.privilege = json['privilege']?.toInt();
	}
	if (json['privilege2'] != null) {
		data.privilege2 = json['privilege2']?.toString();
	}
	if (json['play_url'] != null) {
		data.playUrl = json['play_url']?.toString();
	}
	if (json['authors'] != null) {
		data.authors = new List<SongPlayDataAuthor>();
		(json['authors'] as List).forEach((v) {
			data.authors.add(new SongPlayDataAuthor().fromJson(v));
		});
	}
	if (json['is_free_part'] != null) {
		data.isFreePart = json['is_free_part']?.toInt();
	}
	if (json['bitrate'] != null) {
		data.bitrate = json['bitrate']?.toInt();
	}
	if (json['audio_id'] != null) {
		data.audioId = json['audio_id']?.toString();
	}
	if (json['play_backup_url'] != null) {
		data.playBackupUrl = json['play_backup_url']?.toString();
	}
	return data;
}

Map<String, dynamic> songPlayDataToJson(SongPlayData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['hash'] = entity.hash;
	data['timelength'] = entity.timelength;
	data['filesize'] = entity.filesize;
	data['audio_name'] = entity.audioName;
	data['have_album'] = entity.haveAlbum;
	data['album_name'] = entity.albumName;
	data['album_id'] = entity.albumId;
	data['img'] = entity.img;
	data['have_mv'] = entity.haveMv;
	data['video_id'] = entity.videoId;
	data['author_name'] = entity.authorName;
	data['song_name'] = entity.songName;
	data['lyrics'] = entity.lyrics;
	data['author_id'] = entity.authorId;
	data['privilege'] = entity.privilege;
	data['privilege2'] = entity.privilege2;
	data['play_url'] = entity.playUrl;
	if (entity.authors != null) {
		data['authors'] =  entity.authors.map((v) => v.toJson()).toList();
	}
	data['is_free_part'] = entity.isFreePart;
	data['bitrate'] = entity.bitrate;
	data['audio_id'] = entity.audioId;
	data['play_backup_url'] = entity.playBackupUrl;
	return data;
}

songPlayDataAuthorFromJson(SongPlayDataAuthor data, Map<String, dynamic> json) {
	if (json['author_id'] != null) {
		data.authorId = json['author_id']?.toString();
	}
	if (json['is_publish'] != null) {
		data.isPublish = json['is_publish']?.toString();
	}
	if (json['sizable_avatar'] != null) {
		data.sizableAvatar = json['sizable_avatar']?.toString();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar']?.toString();
	}
	return data;
}

Map<String, dynamic> songPlayDataAuthorToJson(SongPlayDataAuthor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['author_id'] = entity.authorId;
	data['is_publish'] = entity.isPublish;
	data['sizable_avatar'] = entity.sizableAvatar;
	data['author_name'] = entity.authorName;
	data['avatar'] = entity.avatar;
	return data;
}
