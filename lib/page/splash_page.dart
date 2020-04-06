import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:music/util/screenutil.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: window.physicalSize.width, height: window.physicalSize.height);
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 120),
          Image.asset(
            'images/splash_title.png',
            height: ScreenUtil().setHeight(250),
            fit: BoxFit.fitHeight,
          ),
          Expanded(child: Container()),
          Image.asset(
            'images/splash_icon.png',
            height: ScreenUtil().setHeight(100),
            fit: BoxFit.fitHeight,
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }

  void _goToHomePage() {
    Provider.of<PlaySongsModel>(context, listen: false)
        .initPlayList()
        .then((value) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return MainPage();
        }), (router) => router == null);
      });
    });
  }
}
