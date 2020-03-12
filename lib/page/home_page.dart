import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
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

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  StreamManager _streamManager = StreamManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamManager.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InheritedProvider.value(
        value: _streamManager,
        updateShouldNotify: (StreamManager old, StreamManager newManager) =>
            false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HomePageBanner(),
              HotRecommendCard(),
              ElaborateSelectCard()
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset("images/banner${index + 1}.jpg");
          },
          itemCount: 5,
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
              builder: SwiperPagination.dots),
          autoplayDisableOnInteraction: true,
          loop: true,
          duration: 300,
          autoplay: true,
          itemHeight: 150,
          viewportFraction: 0.8,
          scale: 0.9,
        ));
  }
}

class HotRecommendCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    fetchHotRecommendData();
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
              padding: EdgeInsets.only(left: 18, top: 10, bottom: 5),
              child: Text(
                "热门推荐",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: getMoudleHeight(snapshot?.data?.data?.info?.length ?? 0),
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
                    buildItemWidget(context, snapshot?.data?.data?.info[index]),
                itemCount: snapshot?.data?.data?.info?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildItemWidget(BuildContext context, HotRecommandDataInfo info) {
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

double getMoudleHeight(int length) {
  if (length <= 0) return 0.0;
  var height = 0.0;
  height = (length ~/ 3 + (length % 3 > 0 ? 1 : 0)) * 150.0;
  return height + 15;
}

// ignore: must_be_immutable
class ElaborateSelectCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ElaborateSelectCardState();
  }
}

class ElaborateSelectCardState extends State<ElaborateSelectCard> {
  StreamManager _streamManager;

  Future fetchElaborateSelectData() async {
    Response response =
        await HttpManager.getInstance().get("tag/list?pid=0&apiver=2&plat=0");
    if (response == null) return;
    final elaborateSelect =
        ElaborateSelectModelEntity.fromJson(json.decode(response.toString()));
    if (elaborateSelect.status == 1) {
      print("加载数据");
      //将数据输入流中，通知依赖控件刷新UI
      _streamManager.addDataToSink(elaborateSelect);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchElaborateSelectData();
  }

  @override
  Widget build(BuildContext context) {
    _streamManager = StreamManager.of(context);
    return StreamBuilder<dynamic>(
        stream:
            StreamManager.getStreamByKey(context, ElaborateSelectModelEntity),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot == null || snapshot.data == null) {
            return Container();
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildInfo(snapshot.data));
        });
  }

  List<Widget> _buildInfo(ElaborateSelectModelEntity data) {
    List<Widget> widgets = List();
    data.data.info.forEach((ElaborateSelectModelDataInfo info) {
      widgets.addAll(_buildInfoChild(info));
    });
    return widgets;
  }

  List<Widget> _buildInfoChild(ElaborateSelectModelDataInfo info) {
    List<Widget> widget = List();
    if (info == null) return widget;
    info?.children?.removeWhere((ElaborateSelectModelDataInfochild info) =>
        info?.bannerurl?.isEmpty ?? true);
    if (info.children?.isEmpty ?? true) {
      return widget;
    }
    widget.add(Padding(
      padding: EdgeInsets.only(left: 18, top: 10, bottom: 5),
      child: Text(
        info.name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ));
    widget.add(Container(
      height: getMoudleHeight(info?.children?.length ?? 0),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (BuildContext context, int index) =>
            buildItemWidget(context, info?.children[index]),
        itemCount: info?.children?.length ?? 0,
        physics: NeverScrollableScrollPhysics(),
      ),
    ));
    return widget;
  }

  Widget buildItemWidget(
      BuildContext context, ElaborateSelectModelDataInfochild children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            children.bannerurl,
            height: MediaQuery.of(context).size.width / 3 - 18,
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              children.name,
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
