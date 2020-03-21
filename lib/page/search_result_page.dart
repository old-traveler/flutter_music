import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/entity/search_song_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  final String _keyWord;

  SearchResultPage(this._keyWord);

  @override
  State<StatefulWidget> createState() => SearchResultState(_keyWord);
}

class SearchResultState extends State<SearchResultPage> with BaseBloc {
  final String _keyWord;

  SearchResultState(this._keyWord);

  void _fetchSongInfoByKeyWord() {
    dealResponse<SearchSongEntity>(responseProvider: () {
      return HttpManager.getInstance().get(getSearchResultUrl(_keyWord));
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeAll();
  }

  @override
  void initState() {
    super.initState();
    _fetchSongInfoByKeyWord();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider.value(
        value: streamManager,
        updateShouldNotify: (old, news) => false,
        child: Scaffold(
            appBar: AppBar(
              title: Text(_keyWord),
            ),
            body: smartStreamBuilder2<SearchSongEntity>(
                streamManager: streamManager,
                isNoData: (data) => (data?.data?.info?.isEmpty ?? true),
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
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
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
                })));
  }
}
