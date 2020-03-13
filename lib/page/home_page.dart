import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music/bloc/home_page_bloc.dart';
import 'package:music/entity/banner_entity.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    super.initState();
    _homePageBloc = HomePageBloc();
    _homePageBloc.fetchBannerData();
    _homePageBloc.fetchHotRecommendData();
    _homePageBloc.fetchElaborateSelectData();
  }

  @override
  void dispose() {
    super.dispose();
    _homePageBloc.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InheritedProvider.value(
        value: _homePageBloc.streamManager,
        updateShouldNotify: (StreamManager old, StreamManager newManager) =>
            false,
        child: ListView(
          children: <Widget>[
            HomePageBanner(),
            HotRecommendCard(),
            ElaborateSelectCard()
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return smartStreamBuilder<BannerEntity>(
        context: context,
        builder: (BuildContext context, BannerEntity bannerEntity) {
          return Container(
              height: 120,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(bannerEntity.banner[index]);
                },
                itemCount: bannerEntity.banner.length,
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
        });
  }
}

class HotRecommendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return smartStreamBuilder<HotRecommendEntity>(
        context: context,
        builder: (BuildContext context, HotRecommendEntity data) {
          data.data.info.removeWhere((e) => e.bannerurl?.isEmpty ?? true);
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
                height: getModularHeight(data?.data?.info?.length ?? 0),
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
                      buildItemWidget(context, data?.data?.info[index]),
                  itemCount: data?.data?.info?.length ?? 0,
                  physics: NeverScrollableScrollPhysics(),
                ),
              )
            ],
          );
        });
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

double getModularHeight(int length) {
  if (length <= 0) return 0.0;
  var height = 0.0;
  height = (length ~/ 3 + (length % 3 > 0 ? 1 : 0)) * 150.0;
  return height + 15;
}

class ElaborateSelectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return smartStreamBuilder<ElaborateSelectModelEntity>(
        context: context,
        builder: (BuildContext context, ElaborateSelectModelEntity data) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildInfo(data));
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
      height: getModularHeight(info?.children?.length ?? 0),
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
