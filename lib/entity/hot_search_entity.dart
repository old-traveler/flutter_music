class HotSearchEntity {
	int errcode;
	HotSearchData data;
	String error;
	int status;

	HotSearchEntity({this.errcode, this.data, this.error, this.status});

	HotSearchEntity.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		data = json['data'] != null ? new HotSearchData.fromJson(json['data']) : null;
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

class HotSearchData {
	int timestamp;
	List<HotSearchDataInfo> info;

	HotSearchData({this.timestamp, this.info});

	HotSearchData.fromJson(Map<String, dynamic> json) {
		timestamp = json['timestamp'];
		if (json['info'] != null) {
			info = new List<HotSearchDataInfo>();(json['info'] as List).forEach((v) { info.add(new HotSearchDataInfo.fromJson(v)); });
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

class HotSearchDataInfo {
	String jumpurl;
	int sort;
	String keyword;

	HotSearchDataInfo({this.jumpurl, this.sort, this.keyword});

	HotSearchDataInfo.fromJson(Map<String, dynamic> json) {
		jumpurl = json['jumpurl'];
		sort = json['sort'];
		keyword = json['keyword'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['jumpurl'] = this.jumpurl;
		data['sort'] = this.sort;
		data['keyword'] = this.keyword;
		return data;
	}
}
