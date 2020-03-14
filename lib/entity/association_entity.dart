class AssociationEntity {
	int errcode;
	int recordcount;
	List<AssociationData> data;
	String error;
	int status;

	AssociationEntity({this.errcode, this.recordcount, this.data, this.error, this.status});

	AssociationEntity.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		recordcount = json['recordcount'];
		if (json['data'] != null) {
			data = new List<AssociationData>();(json['data'] as List).forEach((v) { data.add(new AssociationData.fromJson(v)); });
		}
		error = json['error'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['errcode'] = this.errcode;
		data['recordcount'] = this.recordcount;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['error'] = this.error;
		data['status'] = this.status;
		return data;
	}
}

class AssociationData {
	int songcount;
	int searchcount;
	String keyword;

	AssociationData({this.songcount, this.searchcount, this.keyword});

	AssociationData.fromJson(Map<String, dynamic> json) {
		songcount = json['songcount'];
		searchcount = json['searchcount'];
		keyword = json['keyword'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['songcount'] = this.songcount;
		data['searchcount'] = this.searchcount;
		data['keyword'] = this.keyword;
		return data;
	}
}
