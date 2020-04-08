import 'package:music/generated/json/base/json_convert_content.dart';
import 'package:music/generated/json/base/json_filed.dart';

class KgSongSheetEntity with JsonConvert<KgSongSheetEntity> {
	@JSONField(name: "JS_CSS_DATE")
	int jsCssDate;
	@JSONField(name: "kg_domain")
	String kgDomain;
	String src;
	dynamic fr;
	String ver;
	KgSongSheetPlist plist;
	int pagesize;
	@JSONField(name: "__Tpl")
	String sTpl;
}

class KgSongSheetPlist with JsonConvert<KgSongSheetPlist> {
	@JSONField(name: "list")
	KgSongSheetPlistList xList;
	int pagesize;
}

class KgSongSheetPlistList with JsonConvert<KgSongSheetPlistList> {
	int timestamp;
	@JSONField(name: "has_next")
	int hasNext;
	List<KgSongSheetPlistListInfo> info;
	int total;
}

class KgSongSheetPlistListInfo with JsonConvert<KgSongSheetPlistListInfo> {
	int recommendfirst;
	String specialname;
	String intro;
	List<KgSongSheetPlistListInfoSong> songs;
	@JSONField(name: "user_type")
	int userType;
	@JSONField(name: "ugc_talent_review")
	dynamic ugcTalentReview;
	List<dynamic> tags;
	String imgurl;
	@JSONField(name: "selected_reason")
	String selectedReason;
	int slid;
	@JSONField(name: "trans_param")
	KgSongSheetPlistListInfoTransParam transParam;
	int percount;
	int specialid;
	int suid;
	String publishtime;
	String singername;
	int verified;
	int playcount;
	int songcount;
	@JSONField(name: "user_avatar")
	String userAvatar;
	String url;
	int collectcount;
	int type;
	String username;
	@JSONField(name: "is_selected")
	int isSelected;
	@JSONField(name: "global_specialid")
	String globalSpecialid;
}

class KgSongSheetPlistListInfoSong with JsonConvert<KgSongSheetPlistListInfoSong> {
	@JSONField(name: "pay_type_320")
	int payType320;
	int m4afilesize;
	@JSONField(name: "price_sq")
	int priceSq;
	int filesize;
	int bitrate;
	@JSONField(name: "trans_param")
	KgSongSheetPlistListInfoSongsTransParam transParam;
	int price;
	int inlist;
	@JSONField(name: "old_cpy")
	int oldCpy;
	@JSONField(name: "fail_process_sq")
	int failProcessSq;
	@JSONField(name: "pay_type")
	int payType;
	@JSONField(name: "topic_url")
	String topicUrl;
	@JSONField(name: "rp_type")
	String rpType;
	@JSONField(name: "pkg_price")
	int pkgPrice;
	int feetype;
	String filename;
	@JSONField(name: "price_320")
	int price320;
	String extname;
	String hash;
	@JSONField(name: "audio_id")
	int audioId;
	int privilege;
	@JSONField(name: "pkg_price_320")
	int pkgPrice320;
	@JSONField(name: "album_id")
	String albumId;
	@JSONField(name: "fail_process_320")
	int failProcess320;
	int sqprivilege;
	String mvhash;
	@JSONField(name: "rp_publish")
	int rpPublish;
	@JSONField(name: "has_accompany")
	int hasAccompany;
	@JSONField(name: "topic_url_sq")
	String topicUrlSq;
	String remark;
	@JSONField(name: "fail_process")
	int failProcess;
	String sqhash;
	int duration;
	int sqfilesize;
	@JSONField(name: "pay_type_sq")
	int payTypeSq;
	@JSONField(name: "album_audio_id")
	int albumAudioId;
	String brief;
	@JSONField(name: "topic_url_320")
	String topicUrl320;
	@JSONField(name: "pkg_price_sq")
	int pkgPriceSq;
}

class KgSongSheetPlistListInfoSongsTransParam with JsonConvert<KgSongSheetPlistListInfoSongsTransParam> {
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

class KgSongSheetPlistListInfoTransParam with JsonConvert<KgSongSheetPlistListInfoTransParam> {
	@JSONField(name: "special_tag")
	int specialTag;
}
