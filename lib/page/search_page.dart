import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/search_page_bloc.dart';
import 'package:music/bloc/smart_state_widget.dart';
import 'package:music/components/state_widget.dart';
import 'package:music/entity/association_entity.dart';
import 'package:music/entity/hot_search_entity.dart';
import 'package:music/page/search_result_page.dart';
import 'package:provider/provider.dart';

/// 搜索页面
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _input;
  TextEditingController _controller;
  SearchPageBloc _searchPageBloc;

  @override
  void initState() {
    super.initState();
    _searchPageBloc = SearchPageBloc()..fetchHotSearchData();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchPageBloc.disposeAll();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider.value(
        value: _searchPageBloc.streamManager,
        updateShouldNotify: (old, newManager) => false,
        child: Scaffold(
          appBar: AppBar(centerTitle: true, title: _buildSearchBar()),
          body: _input?.isNotEmpty ?? false
              ? AssociationWidget()
              : HotSearchWidget(),
        ));
  }

  Widget _buildSearchBar() {
    print("构建搜索输入框");
    List<Widget> searchWidget = List();
    searchWidget.add(Icon(Icons.search, color: Colors.grey));
    searchWidget.add(_buildSearchInput());
    if (_input?.isNotEmpty ?? false) {
      searchWidget.add(IconButton(
        icon: Icon(Icons.cancel, color: Colors.grey),
        onPressed: () {
          setState(() {
            _input = "";
            _controller.clear();
          });
        },
      ));
    }
    return Container(
        height: 40,
        padding: EdgeInsets.only(left: 10, right: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: searchWidget));
  }

  Widget _buildSearchInput() {
    return Expanded(
      child: TextField(
        controller: _controller,
        onChanged: (String input) {
          if ((input?.isEmpty ?? true) || (this._input?.isEmpty ?? true)) {
            print("需要改变按钮状态");
            setState(() {
              _input = input;
            });
          }
          print("发送请求");
          _searchPageBloc.fetchAssociationData(input);
          _input = input;
        },
        style: TextStyle(
          fontSize: 17,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
            border: InputBorder.none,
            hintText: '请输入歌名'),
        onSubmitted: (keyword) {
          /// 点击回车进入搜索结果页
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchResultPage(
                    keyWord: keyword,
                  )));
        },
      ),
    );
  }
}

/// 搜索提示列表
class AssociationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<AssociationEntity>(
        isNoData: (data) => data?.data?.isEmpty ?? true,
        noData: (context, height) => NoDataWidget('暂无数据，换一个词试试～'),
        builder: (BuildContext context, AssociationEntity data) =>
            ListView.separated(
                itemBuilder: (context, index) =>
                    _buildAssociationItem(context, data.data[index]),
                separatorBuilder: (context, index) =>
                    Divider(height: 1, thickness: 0.5),
                itemCount: data.data?.length ?? 0));
  }

  Widget _buildAssociationItem(context, AssociationData itemData) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20),
      leading: Icon(Icons.search),
      title: Text(itemData.keyword),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchResultPage(keyWord: itemData.keyword)));
      },
    );
  }
}

/// 热门搜索模块
class HotSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<HotSearchEntity>(builder: (context, data) {
      List<Widget> widgets = List();
      data.data.info?.forEach((item) {
        widgets.add(_buildHotSearchItem(context, item));
      });
      return Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  "热门搜索",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Wrap(spacing: 8.0, children: widgets),
            ],
          ));
    });
  }

  Widget _buildHotSearchItem(BuildContext context, HotSearchDataInfo item) {
    return GestureDetector(
      child: Chip(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        backgroundColor: Theme.of(context).accentColor,
        label: Text(item.keyword,
            style: TextStyle(color: Colors.white, fontSize: 15)),
        labelPadding: EdgeInsets.symmetric(horizontal: 6),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchResultPage(
                  keyWord: item.keyword,
                )));
      },
    );
  }
}
