import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  void init(PlaySongsModel model) {
    images = model?.curSongInfo?.portrait;
    _timer?.cancel();
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
        List<CachedNetworkImage> imageWidget = [];
        int position = 0;
        images?.forEach((data) {
          imageWidget.add(CachedNetworkImage(
              imageUrl: data,
              fit: BoxFit.fitHeight,
              height: ScreenUtil.screenHeight,
              placeholder: (context, url) {
                return position == 0
                    ? Image.asset(
                        'images/skin_player_bg.jpg',
                        fit: BoxFit.fitHeight,
                        height: ScreenUtil.screenHeight,
                      )
                    : imageWidget[position - 1];
              }));
          position++;
        });
        return images?.isNotEmpty == true
            ? PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: images?.length ?? 0,
                itemBuilder: (context, index) {
                  return imageWidget[index % imageWidget.length];
                },
              )
            : Image.asset(
                'images/skin_player_bg.jpg',
                fit: BoxFit.fitHeight,
                height: ScreenUtil.screenHeight,
              );
      },
    );
  }
}
