class BannerEntity {
	List<String> banner;
	int state;

	BannerEntity({this.banner, this.state});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		banner = json['banner']?.cast<String>();
		state = json['state'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['banner'] = this.banner;
		data['state'] = this.state;
		return data;
	}
}
