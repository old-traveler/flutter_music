import 'package:flutter/cupertino.dart';

String keGouBaseUrl = "http://bjacshow.kugou.com/";

String getLiveUrl({@required int page, int pageSize = 40}) =>
    "show7/json/v2/cdn/index/live/list?platform=1&sign=0e2e8fb44383458f&version=9108&pageSize=$pageSize&gaodeCode=0371&channel=10&page=$page&longitude=113.69&std_plat=5&latitude=34.8";

String get singerUrl =>
    'api/v5/singer/list?version=9108&showtype=1&plat=0&sextype=0&sort=1&pagesize=100&type=0&page=1&musician=0';

String get singListUrl =>
    'singer/mv?singername=风小筝&pagesize=20&singerid=86747&page=1&with_res_tag=1';

String getSearchResultUrl(String keyWord) =>
    "search/song?showtype=14&highlight=em&pagesize=30&tag_aggr="
    "1&tagtype=全部&plat=0&sver=5&keyword=$keyWord&correct=1&"
    "api_ver=1&version=9108&page=1&area_code=1&tag=1&with_res_tag=1";

String get hotSearchUrl => 'search/hot?count=20&plat=1';

String getAssociation(String keyword) =>
    'new/app/i/search.php?student=0&cmd=302&keyword=$keyword&with_res_tag=1';

String get bannerUrl => 'banner.json';

String get hotRecommendUrl => 'tag/recommend?showtype=3&apiver=2&plat=0';

String get stationUrl => 'station.json';

String get songSheetUrl => 'song_sheet.json';

String get elaborateUrl => 'tag/list?pid=0&apiver=2&plat=0';

/// 播放歌曲api
String getSongUrl(String hash) => 'yy/index.php?r=play/getdata&hash=$hash';

/// 获取歌手写真
String getSingerPortrait(
        String albumId, String hash, String filename, String albumAudioId) =>
    'container/v1/image?appid=1005&clientver=10042&author_image_type=4&album_image_type=-3&data=[{"album_id": $albumId,"hash":"$hash","filename":"$filename","album_audio_id": $albumAudioId}]';

/// 获取歌单推荐
String getKgSongSheet(int page) =>
    'plist/index&json=true&page=$page&pagesize=30';
