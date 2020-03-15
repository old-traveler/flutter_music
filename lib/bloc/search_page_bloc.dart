import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music/entity/association_entity.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/entity/hot_search_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';

class SearchPageBloc {
  final StreamManager _streamManager = StreamManager();

  StreamManager get streamManager => _streamManager;

  Future fetchAssociationData(String keyword) async {
    if (keyword?.isEmpty ?? true) {
      addDataToSink(AssociationEntity()..status = 1);
    }
    Response response =
        await HttpManager.getInstanceByUrl("http://msearchcdn.kugou.com/").get(
            "new/app/i/search.php?student=0&cmd=302&keyword=$keyword&with_res_tag=1");
    _dealResponse<AssociationEntity>(response);
  }

  Future fetchHotSearchData() async {
    Response response =
        await HttpManager.getInstance().get("search/hot?count=20&plat=1");
    _dealResponse<HotSearchEntity>(response);
  }

  void _dealResponse<T>(Response response) {
    if (response == null) {
      //网络请求失败
      return;
    }
    String jsonString = response.toString();
    jsonString = jsonString.substring(jsonString.indexOf("{"));
    jsonString = jsonString.substring(0, jsonString.lastIndexOf("}") + 1);
    print("jsonString" + jsonString);
    dynamic data = json.decode(jsonString);
    if (data == null) {
      //json数据为空
      return;
    }
    if (data['status'] == 1) {
      addDataToSink(EntityFactory.generateOBJ<T>(data));
    } else if (data['error'] != null) {
      //打印错误信息
    } else {
      //未知错误
    }
  }

  void addDataToSink(data) {
    _streamManager.addDataToSink(data);
  }

  void dispose(key) {
    _streamManager.dispose(key);
  }

  void disposeAll() {
    _streamManager.disposeAll();
  }
}
