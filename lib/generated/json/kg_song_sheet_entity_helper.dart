import 'package:music/entity/kg_song_sheet_entity.dart';

kgSongSheetEntityFromJson(KgSongSheetEntity data, Map<String, dynamic> json) {
	if (json['JS_CSS_DATE'] != null) {
		data.jsCssDate = json['JS_CSS_DATE']?.toInt();
	}
	if (json['kg_domain'] != null) {
		data.kgDomain = json['kg_domain']?.toString();
	}
	if (json['src'] != null) {
		data.src = json['src']?.toString();
	}
	if (json['fr'] != null) {
		data.fr = json['fr'];
	}
	if (json['ver'] != null) {
		data.ver = json['ver']?.toString();
	}
	if (json['plist'] != null) {
		data.plist = new KgSongSheetPlist().fromJson(json['plist']);
	}
	if (json['pagesize'] != null) {
		data.pagesize = json['pagesize']?.toInt();
	}
	if (json['__Tpl'] != null) {
		data.sTpl = json['__Tpl']?.toString();
	}
	return data;
}

Map<String, dynamic> kgSongSheetEntityToJson(KgSongSheetEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['JS_CSS_DATE'] = entity.jsCssDate;
	data['kg_domain'] = entity.kgDomain;
	data['src'] = entity.src;
	data['fr'] = entity.fr;
	data['ver'] = entity.ver;
	if (entity.plist != null) {
		data['plist'] = entity.plist.toJson();
	}
	data['pagesize'] = entity.pagesize;
	data['__Tpl'] = entity.sTpl;
	return data;
}

kgSongSheetPlistFromJson(KgSongSheetPlist data, Map<String, dynamic> json) {
	if (json['list'] != null) {
		data.xList = new KgSongSheetPlistList().fromJson(json['list']);
	}
	if (json['pagesize'] != null) {
		data.pagesize = json['pagesize']?.toInt();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistToJson(KgSongSheetPlist entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.xList != null) {
		data['list'] = entity.xList.toJson();
	}
	data['pagesize'] = entity.pagesize;
	return data;
}

kgSongSheetPlistListFromJson(KgSongSheetPlistList data, Map<String, dynamic> json) {
	if (json['timestamp'] != null) {
		data.timestamp = json['timestamp']?.toInt();
	}
	if (json['has_next'] != null) {
		data.hasNext = json['has_next']?.toInt();
	}
	if (json['info'] != null) {
		data.info = new List<KgSongSheetPlistListInfo>();
		(json['info'] as List).forEach((v) {
			data.info.add(new KgSongSheetPlistListInfo().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistListToJson(KgSongSheetPlistList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timestamp'] = entity.timestamp;
	data['has_next'] = entity.hasNext;
	if (entity.info != null) {
		data['info'] =  entity.info.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	return data;
}

kgSongSheetPlistListInfoFromJson(KgSongSheetPlistListInfo data, Map<String, dynamic> json) {
	if (json['recommendfirst'] != null) {
		data.recommendfirst = json['recommendfirst']?.toInt();
	}
	if (json['specialname'] != null) {
		data.specialname = json['specialname']?.toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro']?.toString();
	}
	if (json['songs'] != null) {
		data.songs = new List<KgSongSheetPlistListInfoSong>();
		(json['songs'] as List).forEach((v) {
			data.songs.add(new KgSongSheetPlistListInfoSong().fromJson(v));
		});
	}
	if (json['user_type'] != null) {
		data.userType = json['user_type']?.toInt();
	}
	if (json['ugc_talent_review'] != null) {
		data.ugcTalentReview = json['ugc_talent_review'];
	}
	if (json['tags'] != null) {
		data.tags = new List<dynamic>();
		data.tags.addAll(json['tags']);
	}
	if (json['imgurl'] != null) {
		data.imgurl = json['imgurl']?.toString();
	}
	if (json['selected_reason'] != null) {
		data.selectedReason = json['selected_reason']?.toString();
	}
	if (json['slid'] != null) {
		data.slid = json['slid']?.toInt();
	}
	if (json['trans_param'] != null) {
		data.transParam = new KgSongSheetPlistListInfoTransParam().fromJson(json['trans_param']);
	}
	if (json['percount'] != null) {
		data.percount = json['percount']?.toInt();
	}
	if (json['specialid'] != null) {
		data.specialid = json['specialid']?.toInt();
	}
	if (json['suid'] != null) {
		data.suid = json['suid']?.toInt();
	}
	if (json['publishtime'] != null) {
		data.publishtime = json['publishtime']?.toString();
	}
	if (json['singername'] != null) {
		data.singername = json['singername']?.toString();
	}
	if (json['verified'] != null) {
		data.verified = json['verified']?.toInt();
	}
	if (json['playcount'] != null) {
		data.playcount = json['playcount']?.toInt();
	}
	if (json['songcount'] != null) {
		data.songcount = json['songcount']?.toInt();
	}
	if (json['user_avatar'] != null) {
		data.userAvatar = json['user_avatar']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['collectcount'] != null) {
		data.collectcount = json['collectcount']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toInt();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['is_selected'] != null) {
		data.isSelected = json['is_selected']?.toInt();
	}
	if (json['global_specialid'] != null) {
		data.globalSpecialid = json['global_specialid']?.toString();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistListInfoToJson(KgSongSheetPlistListInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['recommendfirst'] = entity.recommendfirst;
	data['specialname'] = entity.specialname;
	data['intro'] = entity.intro;
	if (entity.songs != null) {
		data['songs'] =  entity.songs.map((v) => v.toJson()).toList();
	}
	data['user_type'] = entity.userType;
	data['ugc_talent_review'] = entity.ugcTalentReview;
	if (entity.tags != null) {
		data['tags'] =  [];
	}
	data['imgurl'] = entity.imgurl;
	data['selected_reason'] = entity.selectedReason;
	data['slid'] = entity.slid;
	if (entity.transParam != null) {
		data['trans_param'] = entity.transParam.toJson();
	}
	data['percount'] = entity.percount;
	data['specialid'] = entity.specialid;
	data['suid'] = entity.suid;
	data['publishtime'] = entity.publishtime;
	data['singername'] = entity.singername;
	data['verified'] = entity.verified;
	data['playcount'] = entity.playcount;
	data['songcount'] = entity.songcount;
	data['user_avatar'] = entity.userAvatar;
	data['url'] = entity.url;
	data['collectcount'] = entity.collectcount;
	data['type'] = entity.type;
	data['username'] = entity.username;
	data['is_selected'] = entity.isSelected;
	data['global_specialid'] = entity.globalSpecialid;
	return data;
}

kgSongSheetPlistListInfoSongFromJson(KgSongSheetPlistListInfoSong data, Map<String, dynamic> json) {
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
	if (json['trans_param'] != null) {
		data.transParam = new KgSongSheetPlistListInfoSongsTransParam().fromJson(json['trans_param']);
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
	if (json['fail_process_sq'] != null) {
		data.failProcessSq = json['fail_process_sq']?.toInt();
	}
	if (json['pay_type'] != null) {
		data.payType = json['pay_type']?.toInt();
	}
	if (json['topic_url'] != null) {
		data.topicUrl = json['topic_url']?.toString();
	}
	if (json['rp_type'] != null) {
		data.rpType = json['rp_type']?.toString();
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
	if (json['audio_id'] != null) {
		data.audioId = json['audio_id']?.toInt();
	}
	if (json['privilege'] != null) {
		data.privilege = json['privilege']?.toInt();
	}
	if (json['pkg_price_320'] != null) {
		data.pkgPrice320 = json['pkg_price_320']?.toInt();
	}
	if (json['album_id'] != null) {
		data.albumId = json['album_id']?.toString();
	}
	if (json['fail_process_320'] != null) {
		data.failProcess320 = json['fail_process_320']?.toInt();
	}
	if (json['sqprivilege'] != null) {
		data.sqprivilege = json['sqprivilege']?.toInt();
	}
	if (json['mvhash'] != null) {
		data.mvhash = json['mvhash']?.toString();
	}
	if (json['rp_publish'] != null) {
		data.rpPublish = json['rp_publish']?.toInt();
	}
	if (json['has_accompany'] != null) {
		data.hasAccompany = json['has_accompany']?.toInt();
	}
	if (json['topic_url_sq'] != null) {
		data.topicUrlSq = json['topic_url_sq']?.toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark']?.toString();
	}
	if (json['fail_process'] != null) {
		data.failProcess = json['fail_process']?.toInt();
	}
	if (json['sqhash'] != null) {
		data.sqhash = json['sqhash']?.toString();
	}
	if (json['duration'] != null) {
		data.duration = json['duration']?.toInt();
	}
	if (json['sqfilesize'] != null) {
		data.sqfilesize = json['sqfilesize']?.toInt();
	}
	if (json['pay_type_sq'] != null) {
		data.payTypeSq = json['pay_type_sq']?.toInt();
	}
	if (json['album_audio_id'] != null) {
		data.albumAudioId = json['album_audio_id']?.toInt();
	}
	if (json['brief'] != null) {
		data.brief = json['brief']?.toString();
	}
	if (json['topic_url_320'] != null) {
		data.topicUrl320 = json['topic_url_320']?.toString();
	}
	if (json['pkg_price_sq'] != null) {
		data.pkgPriceSq = json['pkg_price_sq']?.toInt();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistListInfoSongToJson(KgSongSheetPlistListInfoSong entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['pay_type_320'] = entity.payType320;
	data['m4afilesize'] = entity.m4afilesize;
	data['price_sq'] = entity.priceSq;
	data['filesize'] = entity.filesize;
	data['bitrate'] = entity.bitrate;
	if (entity.transParam != null) {
		data['trans_param'] = entity.transParam.toJson();
	}
	data['price'] = entity.price;
	data['inlist'] = entity.inlist;
	data['old_cpy'] = entity.oldCpy;
	data['fail_process_sq'] = entity.failProcessSq;
	data['pay_type'] = entity.payType;
	data['topic_url'] = entity.topicUrl;
	data['rp_type'] = entity.rpType;
	data['pkg_price'] = entity.pkgPrice;
	data['feetype'] = entity.feetype;
	data['filename'] = entity.filename;
	data['price_320'] = entity.price320;
	data['extname'] = entity.extname;
	data['hash'] = entity.hash;
	data['audio_id'] = entity.audioId;
	data['privilege'] = entity.privilege;
	data['pkg_price_320'] = entity.pkgPrice320;
	data['album_id'] = entity.albumId;
	data['fail_process_320'] = entity.failProcess320;
	data['sqprivilege'] = entity.sqprivilege;
	data['mvhash'] = entity.mvhash;
	data['rp_publish'] = entity.rpPublish;
	data['has_accompany'] = entity.hasAccompany;
	data['topic_url_sq'] = entity.topicUrlSq;
	data['remark'] = entity.remark;
	data['fail_process'] = entity.failProcess;
	data['sqhash'] = entity.sqhash;
	data['duration'] = entity.duration;
	data['sqfilesize'] = entity.sqfilesize;
	data['pay_type_sq'] = entity.payTypeSq;
	data['album_audio_id'] = entity.albumAudioId;
	data['brief'] = entity.brief;
	data['topic_url_320'] = entity.topicUrl320;
	data['pkg_price_sq'] = entity.pkgPriceSq;
	return data;
}

kgSongSheetPlistListInfoSongsTransParamFromJson(KgSongSheetPlistListInfoSongsTransParam data, Map<String, dynamic> json) {
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
	if (json['cpy_level'] != null) {
		data.cpyLevel = json['cpy_level']?.toInt();
	}
	if (json['display'] != null) {
		data.display = json['display']?.toInt();
	}
	if (json['exclusive'] != null) {
		data.exclusive = json['exclusive']?.toInt();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistListInfoSongsTransParamToJson(KgSongSheetPlistListInfoSongsTransParam entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cid'] = entity.cid;
	data['pay_block_tpl'] = entity.payBlockTpl;
	data['musicpack_advance'] = entity.musicpackAdvance;
	data['display_rate'] = entity.displayRate;
	data['cpy_level'] = entity.cpyLevel;
	data['display'] = entity.display;
	data['exclusive'] = entity.exclusive;
	return data;
}

kgSongSheetPlistListInfoTransParamFromJson(KgSongSheetPlistListInfoTransParam data, Map<String, dynamic> json) {
	if (json['special_tag'] != null) {
		data.specialTag = json['special_tag']?.toInt();
	}
	return data;
}

Map<String, dynamic> kgSongSheetPlistListInfoTransParamToJson(KgSongSheetPlistListInfoTransParam entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['special_tag'] = entity.specialTag;
	return data;
}