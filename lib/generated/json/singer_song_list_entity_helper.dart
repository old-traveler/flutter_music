import 'package:music/entity/singer_song_list_entity.dart';

singerSongListEntityFromJson(SingerSongListEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['error'] != null) {
		data.error = json['error']?.toString();
	}
	if (json['data'] != null) {
		data.data = new SingerSongListData().fromJson(json['data']);
	}
	if (json['errcode'] != null) {
		data.errcode = json['errcode']?.toInt();
	}
	return data;
}

Map<String, dynamic> singerSongListEntityToJson(SingerSongListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['error'] = entity.error;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['errcode'] = entity.errcode;
	return data;
}

singerSongListDataFromJson(SingerSongListData data, Map<String, dynamic> json) {
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp']?.toInt();
	}
	if (json['info'] != null) {
		data.info = new List<SingerSongListDataInfo>();
		(json['info'] as List).forEach((v) {
			data.info.add(new SingerSongListDataInfo().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> singerSongListDataToJson(SingerSongListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timestamp'] = entity.timestamp;
	if (entity.info != null) {
		data['info'] =  entity.info.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	return data;
}

singerSongListDataInfoFromJson(SingerSongListDataInfo data, Map<String, dynamic> json) {
	if (json['pay_type_320'] != null) {
		data.payType320 = json['pay_type_320']?.toInt();
	}
	if (json['m4afilesize'] != null) {
		data.m4afilesize = json['m4afilesize']?.toInt();
	}
	if (json['price_sq'] != null) {
		data.priceSq = json['price_sq']?.toInt();
	}
	if (json['filesize'] != null) {
		data.filesize = json['filesize']?.toInt();
	}
	if (json['bitrate'] != null) {
		data.bitrate = json['bitrate']?.toInt();
	}
	if (json['identity'] != null) {
		data.identity = json['identity']?.toInt();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toInt();
	}
	if (json['inlist'] != null) {
		data.inlist = json['inlist']?.toInt();
	}
	if (json['old_cpy'] != null) {
		data.oldCpy = json['old_cpy']?.toInt();
	}
	if (json['pkg_price_sq'] != null) {
		data.pkgPriceSq = json['pkg_price_sq']?.toInt();
	}
	if (json['pay_type'] != null) {
		data.payType = json['pay_type']?.toInt();
	}
	if (json['topic_url'] != null) {
		data.topicUrl = json['topic_url']?.toString();
	}
	if (json['fail_process_320'] != null) {
		data.failProcess320 = json['fail_process_320']?.toInt();
	}
	if (json['pkg_price'] != null) {
		data.pkgPrice = json['pkg_price']?.toInt();
	}
	if (json['feetype'] != null) {
		data.feetype = json['feetype']?.toInt();
	}
	if (json['filename'] != null) {
		data.filename = json['filename']?.toString();
	}
	if (json['price_320'] != null) {
		data.price320 = json['price_320']?.toInt();
	}
	if (json['extname'] != null) {
		data.extname = json['extname']?.toString();
	}
	if (json['hash'] != null) {
		data.hash = json['hash']?.toString();
	}
	if (json['mvhash'] != null) {
		data.mvhash = json['mvhash']?.toString();
	}
	if (json['publish_date'] != null) {
		data.publishDate = json['publish_date']?.toString();
	}
	if (json['privilege'] != null) {
		data.privilege = json['privilege']?.toInt();
	}
	if (json['trans_param'] != null) {
		data.transParam = new SingerSongListDataInfoTransParam().fromJson(json['trans_param']);
	}
	if (json['fail_process'] != null) {
		data.failProcess = json['fail_process']?.toInt();
	}
	if (json['album_id'] != null) {
		data.albumId = json['album_id']?.toString();
	}
	if (json['composer_info'] != null) {
		data.composerInfo = new List<SingerSongListDataInfoComposerInfo>();
		(json['composer_info'] as List).forEach((v) {
			data.composerInfo.add(new SingerSongListDataInfoComposerInfo().fromJson(v));
		});
	}
	if (json['album_audio_id'] != null) {
		data.albumAudioId = json['album_audio_id']?.toInt();
	}
	if (json['rp_type'] != null) {
		data.rpType = json['rp_type']?.toString();
	}
	if (json['audio_id'] != null) {
		data.audioId = json['audio_id']?.toInt();
	}
	if (json['rp_publish'] != null) {
		data.rpPublish = json['rp_publish']?.toInt();
	}
	if (json['duration'] != null) {
		data.duration = json['duration']?.toInt();
	}
	if (json['topic_url_sq'] != null) {
		data.topicUrlSq = json['topic_url_sq']?.toString();
	}
	if (json['pkg_price_320'] != null) {
		data.pkgPrice320 = json['pkg_price_320']?.toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark']?.toString();
	}
	if (json['sqhash'] != null) {
		data.sqhash = json['sqhash']?.toString();
	}
	if (json['lyrics_info'] != null) {
		data.lyricsInfo = new List<SingerSongListDataInfoLyricsInfo>();
		(json['lyrics_info'] as List).forEach((v) {
			data.lyricsInfo.add(new SingerSongListDataInfoLyricsInfo().fromJson(v));
		});
	}
	if (json['fail_process_sq'] != null) {
		data.failProcessSq = json['fail_process_sq']?.toInt();
	}
	if (json['has_accompany'] != null) {
		data.hasAccompany = json['has_accompany']?.toInt();
	}
	if (json['pay_type_sq'] != null) {
		data.payTypeSq = json['pay_type_sq']?.toInt();
	}
	if (json['sqprivilege'] != null) {
		data.sqprivilege = json['sqprivilege']?.toInt();
	}
	if (json['topic_url_320'] != null) {
		data.topicUrl320 = json['topic_url_320']?.toString();
	}
	if (json['sqfilesize'] != null) {
		data.sqfilesize = json['sqfilesize']?.toInt();
	}
	return data;
}

Map<String, dynamic> singerSongListDataInfoToJson(SingerSongListDataInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['pay_type_320'] = entity.payType320;
	data['m4afilesize'] = entity.m4afilesize;
	data['price_sq'] = entity.priceSq;
	data['filesize'] = entity.filesize;
	data['bitrate'] = entity.bitrate;
	data['identity'] = entity.identity;
	data['price'] = entity.price;
	data['inlist'] = entity.inlist;
	data['old_cpy'] = entity.oldCpy;
	data['pkg_price_sq'] = entity.pkgPriceSq;
	data['pay_type'] = entity.payType;
	data['topic_url'] = entity.topicUrl;
	data['fail_process_320'] = entity.failProcess320;
	data['pkg_price'] = entity.pkgPrice;
	data['feetype'] = entity.feetype;
	data['filename'] = entity.filename;
	data['price_320'] = entity.price320;
	data['extname'] = entity.extname;
	data['hash'] = entity.hash;
	data['mvhash'] = entity.mvhash;
	data['publish_date'] = entity.publishDate;
	data['privilege'] = entity.privilege;
	if (entity.transParam != null) {
		data['trans_param'] = entity.transParam.toJson();
	}
	data['fail_process'] = entity.failProcess;
	data['album_id'] = entity.albumId;
	if (entity.composerInfo != null) {
		data['composer_info'] =  entity.composerInfo.map((v) => v.toJson()).toList();
	}
	data['album_audio_id'] = entity.albumAudioId;
	data['rp_type'] = entity.rpType;
	data['audio_id'] = entity.audioId;
	data['rp_publish'] = entity.rpPublish;
	data['duration'] = entity.duration;
	data['topic_url_sq'] = entity.topicUrlSq;
	data['pkg_price_320'] = entity.pkgPrice320;
	data['remark'] = entity.remark;
	data['sqhash'] = entity.sqhash;
	if (entity.lyricsInfo != null) {
		data['lyrics_info'] =  entity.lyricsInfo.map((v) => v.toJson()).toList();
	}
	data['fail_process_sq'] = entity.failProcessSq;
	data['has_accompany'] = entity.hasAccompany;
	data['pay_type_sq'] = entity.payTypeSq;
	data['sqprivilege'] = entity.sqprivilege;
	data['topic_url_320'] = entity.topicUrl320;
	data['sqfilesize'] = entity.sqfilesize;
	return data;
}

singerSongListDataInfoTransParamFromJson(SingerSongListDataInfoTransParam data, Map<String, dynamic> json) {
	if (json['cid'] != null) {
		data.cid = json['cid']?.toInt();
	}
	if (json['pay_block_tpl'] != null) {
		data.payBlockTpl = json['pay_block_tpl']?.toInt();
	}
	if (json['musicpack_advance'] != null) {
		data.musicpackAdvance = json['musicpack_advance']?.toInt();
	}
	if (json['display_rate'] != null) {
		data.displayRate = json['display_rate']?.toInt();
	}
	if (json['appid_block'] != null) {
		data.appidBlock = json['appid_block']?.toString();
	}
	if (json['display'] != null) {
		data.display = json['display']?.toInt();
	}
	if (json['cpy_level'] != null) {
		data.cpyLevel = json['cpy_level']?.toInt();
	}
	return data;
}

Map<String, dynamic> singerSongListDataInfoTransParamToJson(SingerSongListDataInfoTransParam entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cid'] = entity.cid;
	data['pay_block_tpl'] = entity.payBlockTpl;
	data['musicpack_advance'] = entity.musicpackAdvance;
	data['display_rate'] = entity.displayRate;
	data['appid_block'] = entity.appidBlock;
	data['display'] = entity.display;
	data['cpy_level'] = entity.cpyLevel;
	return data;
}

singerSongListDataInfoComposerInfoFromJson(SingerSongListDataInfoComposerInfo data, Map<String, dynamic> json) {
	if (json['identity'] != null) {
		data.identity = json['identity']?.toInt();
	}
	if (json['author_id'] != null) {
		data.authorId = json['author_id']?.toInt();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	return data;
}

Map<String, dynamic> singerSongListDataInfoComposerInfoToJson(SingerSongListDataInfoComposerInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['identity'] = entity.identity;
	data['author_id'] = entity.authorId;
	data['author_name'] = entity.authorName;
	return data;
}

singerSongListDataInfoLyricsInfoFromJson(SingerSongListDataInfoLyricsInfo data, Map<String, dynamic> json) {
	if (json['identity'] != null) {
		data.identity = json['identity']?.toInt();
	}
	if (json['author_id'] != null) {
		data.authorId = json['author_id']?.toInt();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	return data;
}

Map<String, dynamic> singerSongListDataInfoLyricsInfoToJson(SingerSongListDataInfoLyricsInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['identity'] = entity.identity;
	data['author_id'] = entity.authorId;
	data['author_name'] = entity.authorName;
	return data;
}