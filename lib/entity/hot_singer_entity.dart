import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class HotSingerEntity with JsonConvert<HotSingerEntity> {
	int status;
	String error;
	HotSingerData data;
	int errcode;
}

class HotSingerData with JsonConvert<HotSingerData> {
	int timestamp;
	List<HotSingerDataInfo> info;
	int total;
}

class HotSingerDataInfo with JsonConvert<HotSingerDataInfo> {
	int heatoffset;
	int sortoffset;
	String singername;
	String intro;
	int albumcount;
	int songcount;
	@JSONField(name: "banner_url")
	String bannerUrl;
	int mvcount;
	int heat;
	int singerid;
	String imgurl;
	int fanscount;
	@JSONField(name: "is_settled")
	int isSettled;
}
