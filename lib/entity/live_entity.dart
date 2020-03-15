class LiveEntity {
	String msg;
	int times;
	int code;
	LiveData data;

	LiveEntity({this.msg, this.times, this.code, this.data});

	LiveEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		times = json['times'];
		code = json['code'];
		data = json['data'] != null ? new LiveData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['times'] = this.times;
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class LiveData {
	int hasNextPage;
	String pkTips;
	List<LiveDataList> xList;

	LiveData({this.hasNextPage, this.pkTips, this.xList});

	LiveData.fromJson(Map<String, dynamic> json) {
		hasNextPage = json['hasNextPage'];
		pkTips = json['pkTips'];
		if (json['list'] != null) {
			xList = new List<LiveDataList>();(json['list'] as List).forEach((v) { xList.add(new LiveDataList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['hasNextPage'] = this.hasNextPage;
		data['pkTips'] = this.pkTips;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LiveDataList {
	String songName;
	int viewerNum;
	String tagsName;
	String animationPath;
	String liveTitle;
	double rankScore;
	LiveDataListSingerext singerExt;
	int source;
	String repreSong;
	String userLogo;
	int roomId;
	int total;
	int pkMode;
	int fixedPosition;
	int rewardAmount;
	String tagsColor;
	int liveStatus;
	String introduction;
	int kugouId;
	int business;
	int guideFlowRedPacket;
	String liveTopic;
	String nickName;
	String activityPic;
	int guideFlowRedPacketV2;
	String label;
	int userId;
	int isVip;
	List<LiveDataListTag> tags;
	int hasRedPacket;
	String imgPath;
	int tagsGroup;
	String starLogo;
	int isOfficialSinger;
	int hasCmdPacket;

	LiveDataList({this.songName, this.viewerNum, this.tagsName, this.animationPath, this.liveTitle, this.rankScore, this.singerExt, this.source, this.repreSong, this.userLogo, this.roomId, this.total, this.pkMode, this.fixedPosition, this.rewardAmount, this.tagsColor, this.liveStatus, this.introduction, this.kugouId, this.business, this.guideFlowRedPacket, this.liveTopic, this.nickName, this.activityPic, this.guideFlowRedPacketV2, this.label, this.userId, this.isVip, this.tags, this.hasRedPacket, this.imgPath, this.tagsGroup, this.starLogo, this.isOfficialSinger, this.hasCmdPacket});

	LiveDataList.fromJson(Map<String, dynamic> json) {
		songName = json['songName'];
		viewerNum = json['viewerNum'];
		tagsName = json['tagsName'];
		animationPath = json['animationPath'];
		liveTitle = json['liveTitle'];
		rankScore = json['rankScore'];
		singerExt = json['singerExt'] != null ? new LiveDataListSingerext.fromJson(json['singerExt']) : null;
		source = json['source'];
		repreSong = json['repreSong'];
		userLogo = json['userLogo'];
		roomId = json['roomId'];
		total = json['total'];
		pkMode = json['pkMode'];
		fixedPosition = json['fixedPosition'];
		rewardAmount = json['rewardAmount'];
		tagsColor = json['tagsColor'];
		liveStatus = json['liveStatus'];
		introduction = json['introduction'];
		kugouId = json['kugouId'];
		business = json['business'];
		guideFlowRedPacket = json['guideFlowRedPacket'];
		liveTopic = json['liveTopic'];
		nickName = json['nickName'];
		activityPic = json['activityPic'];
		guideFlowRedPacketV2 = json['guideFlowRedPacketV2'];
		label = json['label'];
		userId = json['userId'];
		isVip = json['isVip'];
		if (json['tags'] != null) {
			tags = new List<LiveDataListTag>();(json['tags'] as List).forEach((v) { tags.add(new LiveDataListTag.fromJson(v)); });
		}
		hasRedPacket = json['hasRedPacket'];
		imgPath = json['imgPath'];
		tagsGroup = json['tagsGroup'];
		starLogo = json['starLogo'];
		isOfficialSinger = json['isOfficialSinger'];
		hasCmdPacket = json['hasCmdPacket'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['songName'] = this.songName;
		data['viewerNum'] = this.viewerNum;
		data['tagsName'] = this.tagsName;
		data['animationPath'] = this.animationPath;
		data['liveTitle'] = this.liveTitle;
		data['rankScore'] = this.rankScore;
		if (this.singerExt != null) {
      data['singerExt'] = this.singerExt.toJson();
    }
		data['source'] = this.source;
		data['repreSong'] = this.repreSong;
		data['userLogo'] = this.userLogo;
		data['roomId'] = this.roomId;
		data['total'] = this.total;
		data['pkMode'] = this.pkMode;
		data['fixedPosition'] = this.fixedPosition;
		data['rewardAmount'] = this.rewardAmount;
		data['tagsColor'] = this.tagsColor;
		data['liveStatus'] = this.liveStatus;
		data['introduction'] = this.introduction;
		data['kugouId'] = this.kugouId;
		data['business'] = this.business;
		data['guideFlowRedPacket'] = this.guideFlowRedPacket;
		data['liveTopic'] = this.liveTopic;
		data['nickName'] = this.nickName;
		data['activityPic'] = this.activityPic;
		data['guideFlowRedPacketV2'] = this.guideFlowRedPacketV2;
		data['label'] = this.label;
		data['userId'] = this.userId;
		data['isVip'] = this.isVip;
		if (this.tags != null) {
      data['tags'] =  this.tags.map((v) => v.toJson()).toList();
    }
		data['hasRedPacket'] = this.hasRedPacket;
		data['imgPath'] = this.imgPath;
		data['tagsGroup'] = this.tagsGroup;
		data['starLogo'] = this.starLogo;
		data['isOfficialSinger'] = this.isOfficialSinger;
		data['hasCmdPacket'] = this.hasCmdPacket;
		return data;
	}
}

class LiveDataListSingerext {
	String duration;
	String level;
	String hot;
	String nextHot;

	LiveDataListSingerext({this.duration, this.level, this.hot, this.nextHot});

	LiveDataListSingerext.fromJson(Map<String, dynamic> json) {
		duration = json['duration'];
		level = json['level'];
		hot = json['hot'];
		nextHot = json['nextHot'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['duration'] = this.duration;
		data['level'] = this.level;
		data['hot'] = this.hot;
		data['nextHot'] = this.nextHot;
		return data;
	}
}

class LiveDataListTag {
	String tagColor;
	int tagId;
	String tagName;
	String tagUrl;

	LiveDataListTag({this.tagColor, this.tagId, this.tagName, this.tagUrl});

	LiveDataListTag.fromJson(Map<String, dynamic> json) {
		tagColor = json['tagColor'];
		tagId = json['tagId'];
		tagName = json['tagName'];
		tagUrl = json['tagUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['tagColor'] = this.tagColor;
		data['tagId'] = this.tagId;
		data['tagName'] = this.tagName;
		data['tagUrl'] = this.tagUrl;
		return data;
	}
}
