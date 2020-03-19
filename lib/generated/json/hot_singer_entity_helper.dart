import 'package:music/entity/hot_singer_entity.dart';

hotSingerEntityFromJson(HotSingerEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['error'] != null) {
		data.error = json['error']?.toString();
	}
	if (json['data'] != null) {
		data.data = new HotSingerData().fromJson(json['data']);
	}
	if (json['errcode'] != null) {
		data.errcode = json['errcode']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotSingerEntityToJson(HotSingerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['error'] = entity.error;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errcode'] = entity.errcode;
	return data;
}

hotSingerDataFromJson(HotSingerData data, Map<String, dynamic> json) {
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp']?.toInt();
	}
	if (json['info'] != null) {
		data.info = new List<HotSingerDataInfo>();
		(json['info'] as List).forEach((v) {
			data.info.add(new HotSingerDataInfo().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotSingerDataToJson(HotSingerData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timestamp'] = entity.timestamp;
	if (entity.info != null) {
		data['info'] =  entity.info.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	return data;
}

hotSingerDataInfoFromJson(HotSingerDataInfo data, Map<String, dynamic> json) {
	if (json['heatoffset'] != null) {
		data.heatoffset = json['heatoffset']?.toInt();
	}
	if (json['sortoffset'] != null) {
		data.sortoffset = json['sortoffset']?.toInt();
	}
	if (json['singername'] != null) {
		data.singername = json['singername']?.toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro']?.toString();
	}
	if (json['albumcount'] != null) {
		data.albumcount = json['albumcount']?.toInt();
	}
	if (json['songcount'] != null) {
		data.songcount = json['songcount']?.toInt();
	}
	if (json['banner_url'] != null) {
		data.bannerUrl = json['banner_url']?.toString();
	}
	if (json['mvcount'] != null) {
		data.mvcount = json['mvcount']?.toInt();
	}
	if (json['heat'] != null) {
		data.heat = json['heat']?.toInt();
	}
	if (json['singerid'] != null) {
		data.singerid = json['singerid']?.toInt();
	}
	if (json['imgurl'] != null) {
		data.imgurl = json['imgurl']?.toString();
	}
	if (json['fanscount'] != null) {
		data.fanscount = json['fanscount']?.toInt();
	}
	if (json['is_settled'] != null) {
		data.isSettled = json['is_settled']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotSingerDataInfoToJson(HotSingerDataInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['heatoffset'] = entity.heatoffset;
	data['sortoffset'] = entity.sortoffset;
	data['singername'] = entity.singername;
	data['intro'] = entity.intro;
	data['albumcount'] = entity.albumcount;
	data['songcount'] = entity.songcount;
	data['banner_url'] = entity.bannerUrl;
	data['mvcount'] = entity.mvcount;
	data['heat'] = entity.heat;
	data['singerid'] = entity.singerid;
	data['imgurl'] = entity.imgurl;
	data['fanscount'] = entity.fanscount;
	data['is_settled'] = entity.isSettled;
	return data;
}