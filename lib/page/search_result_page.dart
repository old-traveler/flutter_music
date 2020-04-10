import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/bloc/base_bloc.dart' show ResponseWorker;
import 'package:music/bloc/smart_state_widget.dart';
import 'package:music/components/state_widget.dart';
import 'package:music/entity/search_song_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/provider/music_record_model.dart';
import 'package:provider/provider.dart';

openSearchResultPage(BuildContext context, String keyWord) {
  Provider.of<MusicRecordModel>(context, listen: false)
      .addSearchHistory(keyWord);
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchResultPage(keyWord: keyWord)));
}

class SearchResultPage extends StatefulWidget {
  final String keyWord;

  const SearchResultPage({Key key, this.keyWord}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResultPage> with ResponseWorker {
  void _fetchSongInfoByKeyWord() {
    dealResponse<SearchSongEntity>(responseProvider: () {
      return HttpManager.getInstance().get(getSearchResultUrl(widget.keyWord));
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
              title: Text(widget.keyWord),
            ),
            body: _buildBody()));
  }

  Widget _buildBody() {
    return SmartStatePage<SearchSongEntity>(
        noData: (context, height) => NoDataWidget('未找到相关内容'),
        isNoData: (data) => (data?.data?.info?.isEmpty ?? true),
        builder: (context, data) => ListView.builder(
              itemBuilder: (context, index) =>
                  _buildItemWidget(data.data.info[index]),
              itemCount: data?.data?.info?.length ?? 0,
            ));
  }

  Widget _buildItemWidget(SearchSongDataInfo itemData) {
    return ListTile(
        onTap: () {
          openMusicPlayPage(context, itemData);
        },
        contentPadding: EdgeInsets.only(left: 25),
        title: Text(itemData.songname.noTag(),
            maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(itemData.singername.noTag()),
        trailing: _buildTrailing());
  }

  void openMusicPlayPage(BuildContext context, SearchSongDataInfo itemData) {
    openMusicPlayPageByInfo(
        context: context,
        songId: itemData.hash,
        albumId: itemData.albumId,
        filename: itemData.filename,
        albumAudioId: itemData.albumAudioId.toString(),
        songName: itemData.songname,
        singerName: itemData.singername);
  }

  Widget _buildTrailing() {
    return PopupMenuButton<String>(
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
    );
  }
}
