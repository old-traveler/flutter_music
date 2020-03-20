import 'package:music/entity/song_list_entity.dart';

songListEntityFromJson(SongListEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['errcode'] != null) {
		data.errcode = json['errcode']?.toInt();
	}
	if (json['error'] != null) {
		data.error = json['error']?.toString();
	}
	if (json['data'] != null) {
		data.data = new SongListData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> songListEntityToJson(SongListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['errcode'] = entity.errcode;
	data['error'] = entity.error;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

songListDataFromJson(SongListData data, Map<String, dynamic> json) {
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp']?.toInt();
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	if (json['info'] != null) {
		data.info = new List<SongListDataInfo>();
		(json['info'] as List).forEach((v) {
			data.info.add(new SongListDataInfo().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> songListDataToJson(SongListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timestamp'] = entity.timestamp;
	data['total'] = entity.total;
	if (entity.info != null) {
		data['info'] =  entity.info.map((v) => v.toJson()).toList();
	}
	return data;
}

songListDataInfoFromJson(SongListDataInfo data, Map<String, dynamic> json) {
	if (json['filename'] != null) {
		data.filename = json['filename']?.toString();
	}
	if (json['singername'] != null) {
		data.singername = json['singername']?.toString();
	}
	if (json['hash'] != null) {
		data.hash = json['hash']?.toString();
	}
	if (json['imgurl'] != null) {
		data.imgurl = json['imgurl']?.toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro']?.toString();
	}
	return data;
}

Map<String, dynamic> songListDataInfoToJson(SongListDataInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['filename'] = entity.filename;
	data['singername'] = entity.singername;
	data['hash'] = entity.hash;
	data['imgurl'] = entity.imgurl;
	data['intro'] = entity.intro;
	return data;
}