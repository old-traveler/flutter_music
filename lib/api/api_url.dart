import 'package:flutter/cupertino.dart';

String keGouBaseUrl = "http://bjacshow.kugou.com/";

String getLiveUrl({@required int page, int pageSize = 40}) =>
    "show7/json/v2/cdn/index/live/list?platform=1&sign=0e2e8fb44383458f&version=9108&pageSize=$pageSize&gaodeCode=0371&channel=10&page=$page&longitude=113.69&std_plat=5&latitude=34.8";


String get singerUrl => 'api/v5/singer/list?version=9108&showtype=1&plat=0&sextype=0&sort=1&pagesize=100&type=0&page=1&musician=0';