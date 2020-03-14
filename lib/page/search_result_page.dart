import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/entity/entity_factory.dart';
import 'package:music/entity/search_song_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  final String _keyWord;

  SearchResultPage(this._keyWord);

  @override
  State<StatefulWidget> createState() {
    return SearchResultPageState(_keyWord);
  }
}

class SearchResultPageState extends State<SearchResultPage> {
  final String _keyWord;

  SearchResultPageState(this._keyWord);

  StreamManager _streamManager = StreamManager();

  Future fetchSongInfoByKeyWord() async {
    Response response =
        await HttpManager.getInstanceByUrl("http://msearchcdn.kugou.com/").get(
            "api/v3/search/song?showtype=14&highlight=em&pagesize=30&tag_aggr="
            "1&tagtype=全部&plat=0&sver=5&keyword=$_keyWord&correct=1&"
            "api_ver=1&version=9108&page=1&area_code=1&tag=1&with_res_tag=1");
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
      _streamManager
          .addDataToSink(EntityFactory.generateOBJ<SearchSongEntity>(data));
    } else if (data['error'] != null) {
      //打印错误信息
    } else {
      //未知错误
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSongInfoByKeyWord();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider.value(
        value: _streamManager,
        updateShouldNotify: (old, news) => false,
        child: Scaffold(
            appBar: AppBar(
              title: Text(_keyWord),
            ),
            body: LayoutBuilder(
              builder: (context, box) {
                return smartStreamBuilder<SearchSongEntity>(
                    context: context,
                    builder: (context, data) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 25),
                              title: Text(
                                  data.data.info[index].songname
                                      .replaceAll("<em>", "")
                                      .replaceAll("</em>", ""),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              subtitle: Text(data.data.info[index].singername),
                              trailing: PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                onSelected: (value) {},
                                itemBuilder: (context) =>
                                    <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: "star",
                                    child: ListTile(
                                      leading: Icon(Icons.star),
                                      title: Text("收藏"),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "play",
                                    child: ListTile(
                                      leading: Icon(Icons.play_circle_outline),
                                      title: Text("播放"),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "share",
                                    child: ListTile(
                                      leading: Icon(Icons.share),
                                      title: Text("分享"),
                                    ),
                                  ),
                                  PopupMenuDivider(),
                                  PopupMenuItem<String>(
                                    value: "remove",
                                    child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text("删除"),
                                    ),
                                  ),
                                ],
                              ));
                        },
                        itemCount: data?.data?.info?.length ?? 0,
                      );
                    });
              },
            )));
  }
}
