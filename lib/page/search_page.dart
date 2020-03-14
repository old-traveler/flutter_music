import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _input;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: _buildSearchInput()),
      body: _input?.isNotEmpty ?? false
          ? _buildAssociationWidget()
          : _buildHotSearch(),
    );
  }

  Widget _buildAssociationWidget() {}

  Widget _buildHotSearch() {}

  Widget _buildSearchInput() {
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
            setState(() {
              _input = input;
            });
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
