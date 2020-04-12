import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_plugin/flutter_music_plugin.dart';
import 'package:music/entity/bean/music_info.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

class MusicPlayListWidget extends StatefulWidget {
  final List<MusicSongInfo> playList;

  const MusicPlayListWidget({Key key, this.playList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicPlayListState();
}

class MusicPlayListState extends State<MusicPlayListWidget> {
  PlaySongsModel model;

  @override
  Widget build(BuildContext context) {
    return _buildPlayListContent();
  }

  Widget _buildPlayListContent() {
    return Consumer<PlaySongsModel>(builder: (context, model, child) {
      this.model = model;
      if (widget.playList.isNotEmpty &&
          widget.playList.remove(model.curSongInfo)) {
        widget.playList.insert(0, model.curSongInfo);
      }
      return DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.95,
        builder: (context, controller) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Column(
                  children: _buildPlayList(controller, widget.playList)));
        },
      );
    });
  }

  List<Widget> _buildPlayList(
      ScrollController scrollController, List<MusicSongInfo> playList) {
    _buildPlayListTitle() {
      return Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  '播放列表（${playList.length}首）',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              _buildPlayListMoreButton()
            ],
          ));
    }

    return <Widget>[
      _buildPlayListTitle(),
      Divider(height: 1),
      Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            final itemData = playList[index];
            return ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 2),
              leading: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(itemData.sizableCover),
              ),
              title: _buildItemTitle(itemData),
              subtitle: Text(itemData.singerName),
              trailing: _buildTrailing(itemData, playList),
              onTap: () => _onItemTap(itemData),
            );
          },
          itemCount: playList?.length ?? 0,
        ),
      )
    ];
  }

  Widget _buildPlayListMoreButton() {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      onSelected: (value) {
        if(value == 0){
          model.removePlayList();
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: EdgeInsets.only(right: 20),
        width: 50,
        alignment: Alignment.centerRight,
        child: Icon(Icons.more_horiz, color: Colors.grey),
      ),
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: ListTile(title: Text("清空列表")),
        ),
      ],
    );
  }

  Widget _buildItemTitle(MusicSongInfo info) {
    return Text(
      info.songName,
      style: TextStyle(
          color: model.curSongInfo?.hash == info.hash
              ? Colors.blue
              : Colors.black),
    );
  }

  Widget _buildTrailing(MusicSongInfo info, List<MusicSongInfo> playList) {
    bool isPlaying =
        model.curSongInfo?.hash == info.hash && PlaySongsModel.isPlaying(model);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        isPlaying ? Icon(Icons.pause_circle_outline, size: 20) : Container(),
        _buildPopTrailing(info, playList, isPlaying)
      ],
    );
  }

  Widget _buildPopTrailing(
      MusicSongInfo info, List<MusicSongInfo> playList, bool isPlaying) {
    bool canDelete = (info != model.curSongInfo || playList.length > 1);
    final popupList = <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: "play",
        child: ListTile(
          leading: Icon(Icons.play_circle_outline),
          title: Text(isPlaying ? '暂停' : '播放'),
        ),
      ),
    ];
    if (info?.authorId?.isNotEmpty == true) {
      popupList.add(PopupMenuItem<String>(
        value: "singer",
        child: ListTile(
          leading: Icon(Icons.person_outline),
          title: Text('歌手'),
        ),
      ));
    }
    if (canDelete) {
      popupList.add(PopupMenuDivider());
      popupList.add(PopupMenuItem<String>(
        value: "remove",
        child: ListTile(
          leading: Icon(Icons.delete),
          title: Text('删除'),
        ),
      ));
    }

    void _onMenuSelected(String value) {
      if (value == 'remove') {
        setState(() => playList.remove(info));
        model.removeSongInfoById(info.hash);
      } else if (value == 'singer') {
        Navigator.of(context).pushNamed('singer_song',
            arguments: [info.authorId, info.singerName]);
      } else if (value == 'play') {
        _onItemTap(info);
      }
    }

    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      onSelected: _onMenuSelected,
      itemBuilder: (context) => popupList,
    );
  }

  void _onItemTap(MusicSongInfo info) {
    if (model.curSongInfo?.hash == info.hash) {
      MusicWrapper.singleton.playOrPauseMusic();
    } else {
      MusicWrapper.singleton.playMusicById(info.hash);
    }
  }
}
