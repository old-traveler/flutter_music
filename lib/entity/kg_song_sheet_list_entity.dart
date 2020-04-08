import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class KgSongSheetListEntity with JsonConvert<KgSongSheetListEntity> {
	@JSONField(name: "JS_CSS_DATE")
	int jsCssDate;
	@JSONField(name: "kg_domain")
	String kgDomain;
	String src;
	dynamic fr;
	String ver;
	@JSONField(name: "list")
	KgSongSheetListList xList;
	int pagesize;
	@JSONField(name: "__Tpl")
	String sTpl;
}

class KgSongSheetListList with JsonConvert<KgSongSheetListList> {
	@JSONField(name: "list")
	KgSongSheetListListList xList;
	int pagesize;
}

class KgSongSheetListListList with JsonConvert<KgSongSheetListListList> {
	int timestamp;
	List<KgSongSheetListListListInfo> info;
	int total;
}

class KgSongSheetListListListInfo with JsonConvert<KgSongSheetListListListInfo> {
	@JSONField(name: "pay_type_320")
	int payType320;
	int m4afilesize;
	@JSONField(name: "price_sq")
	int priceSq;
	int filesize;
	int bitrate;
	@JSONField(name: "trans_param")
	KgSongSheetListListListInfoTransParam transParam;
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
	int privilege;
	@JSONField(name: "album_id")
	String albumId;
	int sqprivilege;
	@JSONField(name: "album_audio_id")
	int albumAudioId;
	@JSONField(name: "rp_type")
	String rpType;
	@JSONField(name: "rp_publish")
	int rpPublish;
	@JSONField(name: "has_accompany")
	int hasAccompany;
	@JSONField(name: "topic_url_sq")
	String topicUrlSq;
	@JSONField(name: "audio_id")
	int audioId;
	String remark;
	@JSONField(name: "pkg_price_320")
	int pkgPrice320;
	@JSONField(name: "fail_process")
	int failProcess;
	String sqhash;
	int duration;
	int sqfilesize;
	@JSONField(name: "pay_type_sq")
	int payTypeSq;
	@JSONField(name: "fail_process_sq")
	int failProcessSq;
	String brief;
	@JSONField(name: "topic_url_320")
	String topicUrl320;
}

class KgSongSheetListListListInfoTransParam with JsonConvert<KgSongSheetListListListInfoTransParam> {
	int cid;
	@JSONField(name: "pay_block_tpl")
	int payBlockTpl;
	@JSONField(name: "musicpack_advance")
	int musicpackAdvance;
	@JSONField(name: "display_rate")
	int displayRate;
	@JSONField(name: "cpy_level")
	int cpyLevel;
	int display;
	int exclusive;
}
