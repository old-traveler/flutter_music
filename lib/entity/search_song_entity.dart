class SearchSongEntity {
	int errcode;
	SearchSongData data;
	dynamic correct;
	SearchSongBlack black;
	String error;
	int status;
	SearchSongRelative relative;

	SearchSongEntity({this.errcode, this.data, this.correct, this.black, this.error, this.status, this.relative});

	SearchSongEntity.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		data = json['data'] != null ? new SearchSongData.fromJson(json['data']) : null;
		correct = json['correct'];
		black = json['black'] != null ? new SearchSongBlack.fromJson(json['black']) : null;
		error = json['error'];
		status = json['status'];
		relative = json['relative'] != null ? new SearchSongRelative.fromJson(json['relative']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['errcode'] = this.errcode;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['correct'] = this.correct;
		if (this.black != null) {
      data['black'] = this.black.toJson();
    }
		data['error'] = this.error;
		data['status'] = this.status;
		if (this.relative != null) {
      data['relative'] = this.relative.toJson();
    }
		return data;
	}
}

class SearchSongData {
	int total;
	int istagresult;
	String tab;
	int correctiontype;
	int forcecorrection;
	List<SearchSongDataAggregation> aggregation;
	String correctiontip;
	int istag;
	int allowerr;
	List<SearchSongDataInfo> info;
	int timestamp;

	SearchSongData({this.total, this.istagresult, this.tab, this.correctiontype, this.forcecorrection, this.aggregation, this.correctiontip, this.istag, this.allowerr, this.info, this.timestamp});

	SearchSongData.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		istagresult = json['istagresult'];
		tab = json['tab'];
		correctiontype = json['correctiontype'];
		forcecorrection = json['forcecorrection'];
		if (json['aggregation'] != null) {
			aggregation = new List<SearchSongDataAggregation>();(json['aggregation'] as List).forEach((v) { aggregation.add(new SearchSongDataAggregation.fromJson(v)); });
		}
		correctiontip = json['correctiontip'];
		istag = json['istag'];
		allowerr = json['allowerr'];
		if (json['info'] != null) {
			info = new List<SearchSongDataInfo>();(json['info'] as List).forEach((v) { info.add(new SearchSongDataInfo.fromJson(v)); });
		}
		timestamp = json['timestamp'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['istagresult'] = this.istagresult;
		data['tab'] = this.tab;
		data['correctiontype'] = this.correctiontype;
		data['forcecorrection'] = this.forcecorrection;
		if (this.aggregation != null) {
      data['aggregation'] =  this.aggregation.map((v) => v.toJson()).toList();
    }
		data['correctiontip'] = this.correctiontip;
		data['istag'] = this.istag;
		data['allowerr'] = this.allowerr;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		data['timestamp'] = this.timestamp;
		return data;
	}
}

class SearchSongDataAggregation {
	int count;
	String key;

	SearchSongDataAggregation({this.count, this.key});

	SearchSongDataAggregation.fromJson(Map<String, dynamic> json) {
		count = json['count'];
		key = json['key'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['count'] = this.count;
		data['key'] = this.key;
		return data;
	}
}

class SearchSongDataInfo {
	int srctype;
	int bitrate;
	String source;
	String rpType;
	String songnameOriginal;
	int audioId;
	String othername;
	int price;
	String mvhash;
	int feetype;
	String extname;
	int payTypeSq;
	List<Null> group;
	int rpPublish;
	int foldType;
	String othernameOriginal;
	String songname;
	int pkgPrice320;
	int sqprivilege;
	int sqfilesize;
	String filename;
	int m4afilesize;
	String topic;
	int pkgPrice;
	String albumId;
	int pkgPriceSq;
	String hash;
	String singername;
	int failProcess320;
	int failProcessSq;
	int failProcess;
	String sqhash;
	int filesize;
	int privilege;
	int isnew;
	int priceSq;
	int duration;
	int ownercount;
	int payType320;
	SearchSongDataInfoTransParam transParam;
	String albumName;
	int oldCpy;
	int albumAudioId;
	int payType;
	int accompany;
	int sourceid;
	int isoriginal;
	String topicUrl;
	int price320;

	SearchSongDataInfo({this.srctype, this.bitrate, this.source, this.rpType, this.songnameOriginal, this.audioId, this.othername, this.price, this.mvhash, this.feetype, this.extname, this.payTypeSq, this.group, this.rpPublish, this.foldType, this.othernameOriginal, this.songname, this.pkgPrice320, this.sqprivilege, this.sqfilesize, this.filename, this.m4afilesize, this.topic, this.pkgPrice, this.albumId, this.pkgPriceSq, this.hash, this.singername, this.failProcess320, this.failProcessSq, this.failProcess, this.sqhash, this.filesize, this.privilege, this.isnew, this.priceSq, this.duration, this.ownercount, this.payType320, this.transParam, this.albumName, this.oldCpy, this.albumAudioId, this.payType, this.accompany, this.sourceid,  this.isoriginal, this.topicUrl, this.price320});

	SearchSongDataInfo.fromJson(Map<String, dynamic> json) {
		srctype = json['srctype'];
		bitrate = json['bitrate'];
		source = json['source'];
		rpType = json['rp_type'];
		songnameOriginal = json['songname_original'];
		audioId = json['audio_id'];
		othername = json['othername'];
		price = json['price'];
		mvhash = json['mvhash'];
		feetype = json['feetype'];
		extname = json['extname'];
		payTypeSq = json['pay_type_sq'];
		if (json['group'] != null) {
			group = new List<Null>();
		}
		rpPublish = json['rp_publish'];
		foldType = json['fold_type'];
		othernameOriginal = json['othername_original'];
		songname = json['songname'];
		pkgPrice320 = json['pkg_price_320'];
		sqprivilege = json['sqprivilege'];
		sqfilesize = json['sqfilesize'];
		filename = json['filename'];
		m4afilesize = json['m4afilesize'];
		topic = json['topic'];
		pkgPrice = json['pkg_price'];
		albumId = json['album_id'];
		pkgPriceSq = json['pkg_price_sq'];
		hash = json['hash'];
		singername = json['singername'];
		failProcess320 = json['fail_process_320'];
		failProcessSq = json['fail_process_sq'];
		failProcess = json['fail_process'];
		sqhash = json['sqhash'];
		filesize = json['filesize'];
		privilege = json['privilege'];
		isnew = json['isnew'];
		priceSq = json['price_sq'];
		duration = json['duration'];
		ownercount = json['ownercount'];
		payType320 = json['pay_type_320'];
		transParam = json['trans_param'] != null ? new SearchSongDataInfoTransParam.fromJson(json['trans_param']) : null;
		albumName = json['album_name'];
		oldCpy = json['old_cpy'];
		albumAudioId = json['album_audio_id'];
		payType = json['pay_type'];
		accompany = json['Accompany'];
		sourceid = json['sourceid'];
		isoriginal = json['isoriginal'];
		topicUrl = json['topic_url'];
		price320 = json['price_320'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['srctype'] = this.srctype;
		data['bitrate'] = this.bitrate;
		data['source'] = this.source;
		data['rp_type'] = this.rpType;
		data['songname_original'] = this.songnameOriginal;
		data['audio_id'] = this.audioId;
		data['othername'] = this.othername;
		data['price'] = this.price;
		data['mvhash'] = this.mvhash;
		data['feetype'] = this.feetype;
		data['extname'] = this.extname;
		data['pay_type_sq'] = this.payTypeSq;
		if (this.group != null) {
      data['group'] =  [];
    }
		data['rp_publish'] = this.rpPublish;
		data['fold_type'] = this.foldType;
		data['othername_original'] = this.othernameOriginal;
		data['songname'] = this.songname;
		data['pkg_price_320'] = this.pkgPrice320;
		data['sqprivilege'] = this.sqprivilege;
		data['sqfilesize'] = this.sqfilesize;
		data['filename'] = this.filename;
		data['m4afilesize'] = this.m4afilesize;
		data['topic'] = this.topic;
		data['pkg_price'] = this.pkgPrice;
		data['album_id'] = this.albumId;
		data['pkg_price_sq'] = this.pkgPriceSq;
		data['hash'] = this.hash;
		data['singername'] = this.singername;
		data['fail_process_320'] = this.failProcess320;
		data['fail_process_sq'] = this.failProcessSq;
		data['fail_process'] = this.failProcess;
		data['sqhash'] = this.sqhash;
		data['filesize'] = this.filesize;
		data['privilege'] = this.privilege;
		data['isnew'] = this.isnew;
		data['price_sq'] = this.priceSq;
		data['duration'] = this.duration;
		data['ownercount'] = this.ownercount;
		data['pay_type_320'] = this.payType320;
		if (this.transParam != null) {
      data['trans_param'] = this.transParam.toJson();
    }
		data['album_name'] = this.albumName;
		data['old_cpy'] = this.oldCpy;
		data['album_audio_id'] = this.albumAudioId;
		data['pay_type'] = this.payType;
		data['Accompany'] = this.accompany;
		data['sourceid'] = this.sourceid;
		data['isoriginal'] = this.isoriginal;
		data['topic_url'] = this.topicUrl;
		data['price_320'] = this.price320;
		return data;
	}
}

class SearchSongDataInfoTransParam {
	int musicpackAdvance;
	int payBlockTpl;
	int display;
	int exclusive;
	int displayRate;
	int cid;
	SearchSongDataInfoTransParamHashOffset hashOffset;

	SearchSongDataInfoTransParam({this.musicpackAdvance, this.payBlockTpl, this.display, this.exclusive, this.displayRate, this.cid, this.hashOffset});

	SearchSongDataInfoTransParam.fromJson(Map<String, dynamic> json) {
		musicpackAdvance = json['musicpack_advance'];
		payBlockTpl = json['pay_block_tpl'];
		display = json['display'];
		exclusive = json['exclusive'];
		displayRate = json['display_rate'];
		cid = json['cid'];
		hashOffset = json['hash_offset'] != null ? new SearchSongDataInfoTransParamHashOffset.fromJson(json['hash_offset']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['musicpack_advance'] = this.musicpackAdvance;
		data['pay_block_tpl'] = this.payBlockTpl;
		data['display'] = this.display;
		data['exclusive'] = this.exclusive;
		data['display_rate'] = this.displayRate;
		data['cid'] = this.cid;
		if (this.hashOffset != null) {
      data['hash_offset'] = this.hashOffset.toJson();
    }
		return data;
	}
}

class SearchSongDataInfoTransParamHashOffset {
	String offsetHash;
	int startByte;
	int fileType;
	int endMs;
	int endByte;
	int startMs;

	SearchSongDataInfoTransParamHashOffset({this.offsetHash, this.startByte, this.fileType, this.endMs, this.endByte, this.startMs});

	SearchSongDataInfoTransParamHashOffset.fromJson(Map<String, dynamic> json) {
		offsetHash = json['offset_hash'];
		startByte = json['start_byte'];
		fileType = json['file_type'];
		endMs = json['end_ms'];
		endByte = json['end_byte'];
		startMs = json['start_ms'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['offset_hash'] = this.offsetHash;
		data['start_byte'] = this.startByte;
		data['file_type'] = this.fileType;
		data['end_ms'] = this.endMs;
		data['end_byte'] = this.endByte;
		data['start_ms'] = this.startMs;
		return data;
	}
}

class SearchSongBlack {
	int isblock;
	int type;

	SearchSongBlack({this.isblock, this.type});

	SearchSongBlack.fromJson(Map<String, dynamic> json) {
		isblock = json['isblock'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isblock'] = this.isblock;
		data['type'] = this.type;
		return data;
	}
}

class SearchSongRelative {
	dynamic singer;
	int priortype;

	SearchSongRelative({this.singer, this.priortype});

	SearchSongRelative.fromJson(Map<String, dynamic> json) {
		singer = json['singer'];
		priortype = json['priortype'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['singer'] = this.singer;
		data['priortype'] = this.priortype;
		return data;
	}
}
