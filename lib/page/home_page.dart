import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music/bloc/home_page_bloc.dart';
import 'package:music/bloc/smart_state_widget.dart';
import 'package:music/entity/banner_entity.dart';
import 'package:music/entity/elaborate_select_model_entity.dart';
import 'package:music/entity/hot_recommend_entity.dart';
import 'package:music/entity/song_sheet_entity.dart';
import 'package:music/entity/station_entity.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    super.initState();
    _homePageBloc = HomePageBloc()
      ..fetchBannerData()
      ..fetchStationData()
      ..fetchSongSheetData()
      ..fetchHotRecommendData()
      ..fetchElaborateSelectData();
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
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              HomePageBanner(),
              StationCard(),
              SongSheetCard(),
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
    return SmartStatePage<BannerEntity>(
        height: 210,
        builder: (context, bannerEntity) =>
            Container(height: 120, child: _buildBanner(bannerEntity)));
  }

  Widget _buildBanner(BannerEntity bannerEntity) {
    return Swiper(
      itemBuilder: (context, index) =>
          Image.network(bannerEntity.banner[index]),
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
    );
  }
}

class StationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<StationEntity>(
        height: 210,
        builder: (context, data) {
          return Container(
              height: 190.0,
              padding: EdgeInsets.only(left: 10, right: 10, top: 16),
              child: _buildGirdView(data));
        });
  }

  Widget _buildGirdView(StationEntity data) {
    return GridView.builder(
        itemCount: data?.links?.length ?? 0,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.85,
          crossAxisSpacing: 5.0,
        ),
        itemBuilder: (context, index) => _buildItem(data, context, index));
  }

  Widget _buildItem(StationEntity data, BuildContext context, int index) {
    final List<Widget> widgets = [
      Image.network(
        data.links[index].url,
        height: MediaQuery.of(context).size.width / 5 - 28,
        fit: BoxFit.fitHeight,
      ),
      Expanded(
        child: Center(
          child: Text(
            data.links[index].name,
            style: TextStyle(fontSize: 13),
          ),
        ),
      )
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}

class SongSheetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<SongSheetEntity>(
        height: 210,
        builder: (BuildContext context, SongSheetEntity data) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildContent(context, data)));
  }

  List<Widget> _buildContent(BuildContext context, SongSheetEntity data) {
    double leadingSize = (MediaQuery.of(context).size.width - 46) / 2;
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 18, top: 14),
        child: Text(
          data.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          height: leadingSize + 30,
          padding: EdgeInsets.only(left: 18, right: 18, top: 13, bottom: 10),
          child: _buildSongSheetContent(data, leadingSize))
    ];
  }

  Widget _buildSongSheetContent(SongSheetEntity data, double leadingSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildItemView(leadingSize, data.links[0],
            small: false, height: leadingSize + 4),
        SizedBox(width: 2.0),
        Expanded(
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return _buildItemView(
                    (leadingSize + 5) / 2, data.links[index + 1]);
              }),
        )
      ],
    );
  }

  Widget _buildItemView(double size, SongSheetLink info,
      {bool small = true, double height}) {
    return Container(
      height: small ? size : height,
      child: Stack(
        children: <Widget>[
          Image.network(
            info.url,
            fit: BoxFit.fitHeight,
            height: height,
          ),
          _buildListenCount(size, info, small),
          _buildDesc(size, info, small, height)
        ],
      ),
    );
  }

  Widget _buildDesc(
      double size, SongSheetLink info, bool small, double height) {
    return Positioned(
      bottom: 0,
      width: small ? size : height,
      child: Container(
        width: size,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        color: Colors.black38,
        child: Text(
          info.title,
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildListenCount(double size, SongSheetLink info, bool small) {
    return Positioned(
      top: 0,
      right: 0,
      width: small ? size / 1.5 : size / 1.8,
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 3),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00000000), Color(0x8A000000)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.headset,
              color: Colors.white,
              size: small ? 12 : 16,
            ),
            SizedBox(width: 5.0),
            Text(
              info.count,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            SizedBox(width: 5.0),
          ],
        ),
      ),
    );
  }
}

class HotRecommendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<HotRecommendEntity>(
        height: 210,
        builder: (BuildContext context, HotRecommendEntity data) =>
            _buildContentWidget(data));
  }

  Widget _buildContentWidget(HotRecommendEntity data) {
    data.data.info.removeWhere((e) => e.bannerurl?.isEmpty ?? true);
    final List<Widget> widgets = [
      Padding(
        padding: EdgeInsets.only(left: 18, top: 10, bottom: 5),
        child: Text(
          "热门推荐",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: getModularHeight(data?.data?.info?.length ?? 0),
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
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

double getModularHeight(int length) {
  if (length <= 0) return 0.0;
  var height = 0.0;
  height = (length ~/ 3 + (length % 3 > 0 ? 1 : 0)) * 150.0;
  return height + 15;
}

class ElaborateSelectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<ElaborateSelectModelEntity>(
        height: 210,
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
