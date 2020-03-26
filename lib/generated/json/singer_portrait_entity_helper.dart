import 'package:music/entity/singer_portrait_entity.dart';

singerPortraitEntityFromJson(SingerPortraitEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['error_code'] != null) {
		data.errorCode = json['error_code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<SingerPortraitData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new SingerPortraitData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> singerPortraitEntityToJson(SingerPortraitEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['error_code'] = entity.errorCode;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

singerPortraitDataFromJson(SingerPortraitData data, Map<String, dynamic> json) {
	if (json['album'] != null) {
		data.album = new List<SingerPortraitDataAlbum>();
		(json['album'] as List).forEach((v) {
			data.album.add(new SingerPortraitDataAlbum().fromJson(v));
		});
	}
	if (json['author'] != null) {
		data.author = new List<SingerPortraitDataAuthor>();
		(json['author'] as List).forEach((v) {
			data.author.add(new SingerPortraitDataAuthor().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> singerPortraitDataToJson(SingerPortraitData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.album != null) {
		data['album'] =  entity.album.map((v) => v.toJson()).toList();
	}
	if (entity.author != null) {
		data['author'] =  entity.author.map((v) => v.toJson()).toList();
	}
	return data;
}

singerPortraitDataAlbumFromJson(SingerPortraitDataAlbum data, Map<String, dynamic> json) {
	if (json['album_name'] != null) {
		data.albumName = json['album_name']?.toString();
	}
	if (json['album_id'] != null) {
		data.albumId = json['album_id']?.toInt();
	}
	if (json['imgs'] != null) {
		data.imgs = new SingerPortraitDataAlbumImgs().fromJson(json['imgs']);
	}
	if (json['sizable_cover'] != null) {
		data.sizableCover = json['sizable_cover']?.toString();
	}
	if (json['category'] != null) {
		data.category = json['category']?.toInt();
	}
	return data;
}

Map<String, dynamic> singerPortraitDataAlbumToJson(SingerPortraitDataAlbum entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['album_name'] = entity.albumName;
	data['album_id'] = entity.albumId;
	if (entity.imgs != null) {
		data['imgs'] = entity.imgs.toJson();
	}
	data['sizable_cover'] = entity.sizableCover;
	data['category'] = entity.category;
	return data;
}

singerPortraitDataAlbumImgsFromJson(SingerPortraitDataAlbumImgs data, Map<String, dynamic> json) {
	return data;
}

Map<String, dynamic> singerPortraitDataAlbumImgsToJson(SingerPortraitDataAlbumImgs entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	return data;
}

singerPortraitDataAuthorFromJson(SingerPortraitDataAuthor data, Map<String, dynamic> json) {
	if (json['imgs'] != null) {
		data.imgs = new SingerPortraitDataAuthorImgs().fromJson(json['imgs']);
	}
	if (json['author_id'] != null) {
		data.authorId = json['author_id']?.toInt();
	}
	if (json['sizable_avatar'] != null) {
		data.sizableAvatar = json['sizable_avatar']?.toString();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	return data;
}

Map<String, dynamic> singerPortraitDataAuthorToJson(SingerPortraitDataAuthor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.imgs != null) {
		data['imgs'] = entity.imgs.toJson();
	}
	data['author_id'] = entity.authorId;
	data['sizable_avatar'] = entity.sizableAvatar;
	data['author_name'] = entity.authorName;
	return data;
}

singerPortraitDataAuthorImgsFromJson(SingerPortraitDataAuthorImgs data, Map<String, dynamic> json) {
	List<dynamic> list = json['4'];
	if(list?.isNotEmpty == true){
		List<SingerPortraitDataAuthorImgs4> images =[];
		for (var value in list) {
		  images.add(singerPortraitDataAuthorImgs4FromJson(SingerPortraitDataAuthorImgs4(), value));
		}
		data.imageList = images;
	}
	return data;
}

Map<String, dynamic> singerPortraitDataAuthorImgsToJson(SingerPortraitDataAuthorImgs entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	return data;
}

singerPortraitDataAuthorImgs4FromJson(SingerPortraitDataAuthorImgs4 data, Map<String, dynamic> json) {
	if (json['sizable_portrait'] != null) {
		data.sizablePortrait = json['sizable_portrait']?.toString();
	}
	if (json['file_hash'] != null) {
		data.fileHash = json['file_hash']?.toString();
	}
	return data;
}

Map<String, dynamic> singerPortraitDataAuthorImgs4ToJson(SingerPortraitDataAuthorImgs4 entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sizable_portrait'] = entity.sizablePortrait;
	data['file_hash'] = entity.fileHash;
	return data;
}