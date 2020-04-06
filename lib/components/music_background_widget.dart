import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/api/api_url.dart';
import 'package:music/entity/singer_portrait_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';
import 'package:music/util/toast_util.dart';
import 'package:music/generated/json/singer_portrait_entity_helper.dart';
import 'package:provider/provider.dart';

class MusicBackgroundWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MusicBackgroundState();
}

class MusicBackgroundState extends State<MusicBackgroundWidget> {
  List<String> images;
  int _index = 0;
  Timer _timer;
  PageController _pageController = PageController();
  Duration period = const Duration(seconds: 15);
  String _songId;

  void init(PlaySongsModel model) {
    final hash = model?.curSongInfo?.hash;
    if (_songId != null && _songId == hash) {
      return;
    }
    _songId = hash;
    images = model?.curSongInfo?.portrait;
    _timer?.cancel();
    _index = 0;
    _timer = null;
    if (images == null) {
      //无数据需要更新数据
      _fetchSongPortrait(model);
    } else {
      /// 开启计数器
      startTime();
    }
  }

  startTime() {
    _timer?.cancel();
    _timer = Timer.periodic(period, (timer) {
      _pageController.jumpToPage((_index++) % images.length);
    });
  }

  Future _fetchSongPortrait(PlaySongsModel model) async {
    final info = model.curSongInfo;
    if (info == null) {
      return;
    }
    Response response =
        await HttpManager.getInstanceByUrl('http://kmrcdn.service.kugou.com/')
            .get(getSingerPortrait(
                info.albumId, info.hash, info.filename, info.albumAudioId));
    print("http://kmrcdn.service.kugou.com/" +
        getSingerPortrait(
            info.albumId, info.hash, info.filename, info.albumAudioId));
    print(response.toString());
    if (response == null) {
      ToastUtil.show(context: context, msg: '网络不给力');
      return;
    }
    SingerPortraitEntity entity = singerPortraitEntityFromJson(
        SingerPortraitEntity(), json.decode(response.toString()));
    if (mounted) {
      if (entity?.data == null) {
        return;
      }
      images = entity?.data[0]?.author[0]?.imgs?.imageList?.map<String>((data) {
        return data.sizablePortrait;
      })?.toList();
      if (images == null) {
        return;
      }
      model.updatePortrait(info.hash, images);
      startTime();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        init(model);
        return Container(
          child: images?.isNotEmpty == true
              ? _buildPortrait()
              : _buildDefaultPortrait(),
          foregroundDecoration: BoxDecoration(color: Colors.black26),
        );
      },
    );
  }

  Widget _buildPortrait() {
    return PageView.builder(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: images?.length ?? 0,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
            imageUrl: images[index % images.length],
            fit: BoxFit.fitHeight,
            height: ScreenUtil.screenHeight,
            placeholder: (context, url) => _buildPlaceholder(index));
      },
    );
  }

  Widget _buildPlaceholder(int index) {
    return index % images.length == 0
        ? Image.asset(
            'images/skin_player_bg.jpg',
            fit: BoxFit.fitHeight,
            height: ScreenUtil.screenHeight,
          )
        : CachedNetworkImage(
            imageUrl: images[(index - 1) % images.length],
            fit: BoxFit.fitHeight,
            height: ScreenUtil.screenHeight);
  }

  Widget _buildDefaultPortrait() {
    return Image.asset(
      'images/skin_player_bg.jpg',
      fit: BoxFit.fitHeight,
      height: ScreenUtil.screenHeight,
    );
  }
}
