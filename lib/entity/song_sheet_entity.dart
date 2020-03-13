class SongSheetEntity {
	String name;
	List<SongSheetLink> links;
	int status;

	SongSheetEntity({this.name, this.links, this.status});

	SongSheetEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		if (json['links'] != null) {
			links = new List<SongSheetLink>();(json['links'] as List).forEach((v) { links.add(new SongSheetLink.fromJson(v)); });
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

class SongSheetLink {
	String name;
	String count;
	String title;
	String url;

	SongSheetLink({this.name, this.count, this.title, this.url});

	SongSheetLink.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		count = json['count'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['count'] = this.count;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}
