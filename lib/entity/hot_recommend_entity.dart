class HotRecommendEntity {
	int errcode;
	HotRecommendData data;
	String error;
	int status;

	HotRecommendEntity({this.errcode, this.data, this.error, this.status});

	HotRecommendEntity.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		data = json['data'] != null ? new HotRecommendData.fromJson(json['data']) : null;
		error = json['error'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['errcode'] = this.errcode;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['error'] = this.error;
		data['status'] = this.status;
		return data;
	}
}

class HotRecommendData {
	int timestamp;
	List<HotRecommandDataInfo> info;

	HotRecommendData({this.timestamp, this.info});

	HotRecommendData.fromJson(Map<String, dynamic> json) {
		timestamp = json['timestamp'];
		if (json['info'] != null) {
			info = new List<HotRecommandDataInfo>();(json['info'] as List).forEach((v) { info.add(new HotRecommandDataInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['timestamp'] = this.timestamp;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HotRecommandDataInfo {
	String imgurl;
	String jumpUrl;
	int songTagId;
	int isNew;
	int specialTagId;
	String icon;
	String bannerurl;
	String name;
	int albumTagId;
	int theme;
	int id;
	int hasChild;

	HotRecommandDataInfo({this.imgurl, this.jumpUrl, this.songTagId, this.isNew, this.specialTagId, this.icon, this.bannerurl, this.name, this.albumTagId, this.theme, this.id, this.hasChild});

	HotRecommandDataInfo.fromJson(Map<String, dynamic> json) {
		imgurl = json['imgurl'];
		jumpUrl = json['jump_url'];
		songTagId = json['song_tag_id'];
		isNew = json['is_new'];
		specialTagId = json['special_tag_id'];
		icon = json['icon'];
		bannerurl = json['bannerurl'];
		name = json['name'];
		albumTagId = json['album_tag_id'];
		theme = json['theme'];
		id = json['id'];
		hasChild = json['has_child'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgurl'] = this.imgurl;
		data['jump_url'] = this.jumpUrl;
		data['song_tag_id'] = this.songTagId;
		data['is_new'] = this.isNew;
		data['special_tag_id'] = this.specialTagId;
		data['icon'] = this.icon;
		data['bannerurl'] = this.bannerurl;
		data['name'] = this.name;
		data['album_tag_id'] = this.albumTagId;
		data['theme'] = this.theme;
		data['id'] = this.id;
		data['has_child'] = this.hasChild;
		return data;
	}
}
