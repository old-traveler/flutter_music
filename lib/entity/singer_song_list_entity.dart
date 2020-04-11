import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class SingerSongListEntity with JsonConvert<SingerSongListEntity> {
	int status;
	String error;
	SingerSongListData data;
	int errcode;
}

class SingerSongListData with JsonConvert<SingerSongListData> {
	int timestamp;
	List<SingerSongListDataInfo> info;
	int total;
}

class SingerSongListDataInfo with JsonConvert<SingerSongListDataInfo> {
	@JSONField(name: "pay_type_320")
	int payType320;
	int m4afilesize;
	@JSONField(name: "price_sq")
	int priceSq;
	int filesize;
	int bitrate;
	int identity;
	int price;
	int inlist;
	@JSONField(name: "old_cpy")
	int oldCpy;
	@JSONField(name: "pkg_price_sq")
	int pkgPriceSq;
	@JSONField(name: "pay_type")
	int payType;
	@JSONField(name: "topic_url")
	String topicUrl;
	@JSONField(name: "fail_process_320")
	int failProcess320;
	@JSONField(name: "pkg_price")
	int pkgPrice;
	int feetype;
	String filename;
	@JSONField(name: "price_320")
	int price320;
	String extname;
	String hash;
	String mvhash;
	@JSONField(name: "publish_date")
	String publishDate;
	int privilege;
	@JSONField(name: "trans_param")
	SingerSongListDataInfoTransParam transParam;
	@JSONField(name: "fail_process")
	int failProcess;
	@JSONField(name: "album_id")
	String albumId;
	@JSONField(name: "composer_info")
	List<SingerSongListDataInfoComposerInfo> composerInfo;
	@JSONField(name: "album_audio_id")
	int albumAudioId;
	@JSONField(name: "rp_type")
	String rpType;
	@JSONField(name: "audio_id")
	int audioId;
	@JSONField(name: "rp_publish")
	int rpPublish;
	int duration;
	@JSONField(name: "topic_url_sq")
	String topicUrlSq;
	@JSONField(name: "pkg_price_320")
	int pkgPrice320;
	String remark;
	String sqhash;
	@JSONField(name: "lyrics_info")
	List<SingerSongListDataInfoLyricsInfo> lyricsInfo;
	@JSONField(name: "fail_process_sq")
	int failProcessSq;
	@JSONField(name: "has_accompany")
	int hasAccompany;
	@JSONField(name: "pay_type_sq")
	int payTypeSq;
	int sqprivilege;
	@JSONField(name: "topic_url_320")
	String topicUrl320;
	int sqfilesize;
}

class SingerSongListDataInfoTransParam with JsonConvert<SingerSongListDataInfoTransParam> {
	int cid;
	@JSONField(name: "pay_block_tpl")
	int payBlockTpl;
	@JSONField(name: "musicpack_advance")
	int musicpackAdvance;
	@JSONField(name: "display_rate")
	int displayRate;
	@JSONField(name: "appid_block")
	String appidBlock;
	int display;
	@JSONField(name: "cpy_level")
	int cpyLevel;
}

class SingerSongListDataInfoComposerInfo with JsonConvert<SingerSongListDataInfoComposerInfo> {
	int identity;
	@JSONField(name: "author_id")
	int authorId;
	@JSONField(name: "author_name")
	String authorName;
}

class SingerSongListDataInfoLyricsInfo with JsonConvert<SingerSongListDataInfoLyricsInfo> {
	int identity;
	@JSONField(name: "author_id")
	int authorId;
	@JSONField(name: "author_name")
	String authorName;
}
