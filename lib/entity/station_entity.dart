class StationEntity {
	String name;
	List<StationLink> links;
	int status;

	StationEntity({this.name, this.links, this.status});

	StationEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		if (json['links'] != null) {
			links = new List<StationLink>();(json['links'] as List).forEach((v) { links.add(new StationLink.fromJson(v)); });
		}
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		if (this.links != null) {
      data['links'] =  this.links.map((v) => v.toJson()).toList();
    }
		data['status'] = this.status;
		return data;
	}
}

class StationLink {
	String name;
	String url;

	StationLink({this.name, this.url});

	StationLink.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['url'] = this.url;
		return data;
	}
}
