import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/search_page_bloc.dart';
import 'package:music/entity/association_entity.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

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
    _searchPageBloc = SearchPageBloc();
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
        updateShouldNotify: (StreamManager old, StreamManager newManager) =>
            false,
        child: Container(
            color: Colors.white,
            child: Scaffold(
              appBar: AppBar(centerTitle: true, title: _buildSearchInput()),
              body: _input?.isNotEmpty ?? false
                  ? AssociationWidget()
                  : _buildHotSearch(),
            )));
  }

  Widget _buildHotSearch() {}

  Widget _buildSearchInput() {
    print("构建搜索输入框");
    List<Widget> searchWidget = List();
    searchWidget.add(
      Icon(
        Icons.search,
        color: Colors.grey,
      ),
    );
    searchWidget.add(
      Expanded(
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
        ),
      ),
    );
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
}

class AssociationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return smartStreamBuilder<AssociationEntity>(
        context: context,
        builder: (BuildContext context, AssociationEntity data) {
          return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.only(left: 20),

                    leading: Icon(Icons.search),
                    title: Text(data.data[index].keyword),
                  ),
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 0.5,
                  ),
              itemCount: data.data?.length ?? 0);
        });
  }
}
