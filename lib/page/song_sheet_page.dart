import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/kg_song_sheet_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/song_sheet_song_list.dart';

class SongSheetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongSheetState(SongSheetBloc());
}

class SongSheetBloc with ResponseWorker, ListPageWorker {
  @override
  listResponseProvider() =>
      (page, offset) => HttpManager.getInstanceByUrl('http://m.kugou.com/')
          .get(getKgSongSheet(page));
}

class SongSheetState extends BaseListState<KgSongSheetEntity, SongSheetPage> {
  SongSheetState(ListPageWorker baseListBloc) : super(baseListBloc);

  @override
  Widget wrapContent(Widget contentWidget) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单广场'),
      ),
      body: contentWidget,
    );
  }

  @override
  Widget buildItem(BuildContext context, data, int index) {
    final KgSongSheetPlistListInfo itemData = data;
    return GestureDetector(
        child: _buildItemWidget(itemData), onTap: () => _onItemTap(itemData));
  }

  void _onItemTap(KgSongSheetPlistListInfo itemData) {
    final router = MaterialPageRoute(builder: (context) {
      return SongSheetSongListPage(
        specialId: itemData.specialid.toString(),
        title: itemData.specialname,
        intro: itemData.intro,
        imageUrl: itemData.imgurl.replaceAll('{size}', '150'),
        userAvatar: itemData.userAvatar,
        username: itemData.username,
      );
    });
    Navigator.of(context).push(router);
  }

  Widget _buildItemWidget(KgSongSheetPlistListInfo itemData) {
    final widgets = <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _buildSongSheet(itemData)),
      SizedBox(
        height: 2,
      ),
      Expanded(
          child: Center(
        child: Text(
          itemData.specialname ?? "null",
          style: TextStyle(fontSize: 13),
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ))
    ];
    return Column(
      children: widgets,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildSongSheet(KgSongSheetPlistListInfo itemData) {
    final playCount = itemData?.playcount ?? 1;
    String playCountTip =
        playCount > 10000 ? '${playCount ~/ 10000}万' : playCount.toString();
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
            imageUrl: itemData.imgurl.replaceAll('{size}', '150')),
        Positioned(
            left: 5,
            bottom: 5,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  playCountTip,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )),
      ],
    );
  }

  @override
  Widget buildListView(KgSongSheetEntity data, int itemAndHeaderCount) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          childAspectRatio: 0.75),
      itemBuilder: (context, index) => itemBuilder(context, index),
      itemCount: itemAndHeaderCount,
    );
  }

  @override
  List getListData(KgSongSheetEntity data) {
    return data?.plist?.xList?.info;
  }

  @override
  bool hasNextPage(KgSongSheetEntity data) {
    return data?.plist?.xList?.hasNext == 1;
  }
}
