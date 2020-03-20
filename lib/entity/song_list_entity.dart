import 'package:music/generated/json/base/json_convert_content.dart';

class SongListEntity with JsonConvert<SongListEntity> {
	int status;
	int errcode;
	String error;
	SongListData data;
}

class SongListData with JsonConvert<SongListData> {
	int timestamp;
	int total;
	List<SongListDataInfo> info;
}

class SongListDataInfo with JsonConvert<SongListDataInfo> {
	String filename;
	String singername;
	String hash;
	String imgurl;
	String intro;
}
