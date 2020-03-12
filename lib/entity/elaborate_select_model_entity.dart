class ElaborateSelectModelEntity {
	int errcode;
	ElaborateSelectModelData data;
	String error;
	int status;

	ElaborateSelectModelEntity({this.errcode, this.data, this.error, this.status});

	ElaborateSelectModelEntity.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		data = json['data'] != null ? new ElaborateSelectModelData.fromJson(json['data']) : null;
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

class ElaborateSelectModelData {
	int timestamp;
	List<ElaborateSelectModelDataInfo> info;

	ElaborateSelectModelData({this.timestamp, this.info});

	ElaborateSelectModelData.fromJson(Map<String, dynamic> json) {
		timestamp = json['timestamp'];
		if (json['info'] != null) {
			info = new List<ElaborateSelectModelDataInfo>();(json['info'] as List).forEach((v) { info.add(new ElaborateSelectModelDataInfo.fromJson(v)); });
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

class ElaborateSelectModelDataInfo {
	List<ElaborateSelectModelDataInfochild> children;
	String subtitle;
	String icon;
	String name;
	String description;
	int hasChild;
	int id;

	ElaborateSelectModelDataInfo({this.children, this.subtitle, this.icon, this.name, this.description, this.hasChild, this.id});

	ElaborateSelectModelDataInfo.fromJson(Map<String, dynamic> json) {
		if (json['children'] != null) {
			children = new List<ElaborateSelectModelDataInfochild>();(json['children'] as List).forEach((v) { children.add(new ElaborateSelectModelDataInfochild.fromJson(v)); });
		}
		subtitle = json['subtitle'];
		icon = json['icon'];
		name = json['name'];
		description = json['description'];
		hasChild = json['has_child'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.children != null) {
      data['children'] =  this.children.map((v) => v.toJson()).toList();
    }
		data['subtitle'] = this.subtitle;
		data['icon'] = this.icon;
		data['name'] = this.name;
		data['description'] = this.description;
		data['has_child'] = this.hasChild;
		data['id'] = this.id;
		return data;
	}
}

class ElaborateSelectModelDataInfochild {
	String bannerHd;
	int isNew;
	int albumTagId;
	String icon;
	String bannerurl;
	String description;
	String imgurl;
	String jumpUrl;
	int songTagId;
	int isHot;
	int specialTagId;
	String subtitle;
	String name;
	int theme;
	int id;
	int hasChild;

	ElaborateSelectModelDataInfochild({this.bannerHd, this.isNew, this.albumTagId, this.icon, this.bannerurl, this.description, this.imgurl, this.jumpUrl, this.songTagId, this.isHot, this.specialTagId, this.subtitle, this.name, this.theme, this.id, this.hasChild});

	ElaborateSelectModelDataInfochild.fromJson(Map<String, dynamic> json) {
		bannerHd = json['banner_hd'];
		isNew = json['is_new'];
		albumTagId = json['album_tag_id'];
		icon = json['icon'];
		bannerurl = json['bannerurl'];
		description = json['description'];
		imgurl = json['imgurl'];
		jumpUrl = json['jump_url'];
		songTagId = json['song_tag_id'];
		isHot = json['is_hot'];
		specialTagId = json['special_tag_id'];
		subtitle = json['subtitle'];
		name = json['name'];
		theme = json['theme'];
		id = json['id'];
		hasChild = json['has_child'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['banner_hd'] = this.bannerHd;
		data['is_new'] = this.isNew;
		data['album_tag_id'] = this.albumTagId;
		data['icon'] = this.icon;
		data['bannerurl'] = this.bannerurl;
		data['description'] = this.description;
		data['imgurl'] = this.imgurl;
		data['jump_url'] = this.jumpUrl;
		data['song_tag_id'] = this.songTagId;
		data['is_hot'] = this.isHot;
		data['special_tag_id'] = this.specialTagId;
		data['subtitle'] = this.subtitle;
		data['name'] = this.name;
		data['theme'] = this.theme;
		data['id'] = this.id;
		data['has_child'] = this.hasChild;
		return data;
	}
}
