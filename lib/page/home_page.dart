import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  StreamManager _streamManager = StreamManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider.value(
      value: _streamManager,
      updateShouldNotify: (StreamManager old, StreamManager newManager) =>
          old != newManager,
      child: ListView(
        children: <Widget>[HotRecommendCard()],
      ),
    );
  }
}

class HotRecommendCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotRecommendState();
  }
}

class HotRecommendState extends State<HotRecommendCard> {
  StreamManager _streamManager;

  Future fetchHotRecommendData() async {
    Response response = await HttpManager.getInstance()
        .get("tag/recommend?showtype=3&apiver=2&plat=0");
    if (response == null) return;
    final hotRecommend =
        HotRecommendEntity.fromJson(json.decode(response.toString()));
    print("网络请求完成");
    if (hotRecommend.status == 1) {
      print("加载数据");
      hotRecommend.data.info.removeWhere(
          (HotRecommandDataInfo info) => info.bannerurl?.isEmpty ?? true);
      _streamManager.addDataToSink(hotRecommend);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHotRecommendData();
  }

  @override
  Widget build(BuildContext context) {
    _streamManager = Provider.of<StreamManager>(context);
    return StreamBuilder<dynamic>(
      stream: StreamManager.getStreamByKey(context, HotRecommendEntity),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot == null || snapshot.data == null) {
          return Container();
        }
        print("加载数据到Widget上");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18, top: 10),
              child: Text(
                "热门推荐",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 500,
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    buildItemWidget(snapshot?.data?.data?.info[index]),
                itemCount: snapshot?.data?.data?.info?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildItemWidget(HotRecommandDataInfo info) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            info.bannerurl,
            height: MediaQuery.of(context).size.width / 3 - 18,
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              info.name,
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
}

class TypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TypePageState();
  }
}

class TypePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("分类"),
    );
  }
}

class RankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RankPageState();
  }
}

class RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("排行榜"),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("我的"),
    );
  }
}
