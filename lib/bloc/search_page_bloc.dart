import 'dart:async';

import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/association_entity.dart';
import 'package:music/entity/hot_search_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/api/api_url.dart';

/// 搜索页面Bloc
class SearchPageBloc with ResponseWorker {
  Timer _timer;

  void fetchAssociationData(String keyword) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(const Duration(milliseconds: 300), () {
      fetchAssociationDataInternal(keyword);
    });
  }

  void fetchAssociationDataInternal(String keyword) {
    print("fetchAssociationDataInternal :$keyword");
    if (keyword?.isEmpty ?? true) {
      //发送一个空数据清空之前的联想词
      streamManager.addDataToSinkByKey(AssociationEntity,
          PageData.complete(AssociationEntity()..status = 1));
      return;
    }
    dealResponse<AssociationEntity>(
        responseProvider: () =>
            HttpManager.getInstanceByUrl("http://msearchcdn.kugou.com/")
                .get(getAssociation(keyword)));
  }

  void fetchHotSearchData() {
    dealResponse<HotSearchEntity>(
        responseProvider: () => HttpManager.getInstance().get(hotSearchUrl));
  }
}
