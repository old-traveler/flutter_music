import 'package:flutter/material.dart';
import 'package:music/util/screenutil.dart';

class ImageMenuWidget extends StatelessWidget {
  final String img;
  final double size;
  final VoidCallback onTap;

  ImageMenuWidget(this.img, this.size, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        img,
        width: ScreenUtil().setWidth(size),
        height: ScreenUtil().setWidth(size),
      ),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final String img;
  final double size;
  final VoidCallback onTap;

  BackgroundImageWidget(this.img, this.size, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(30)),
      child: Image.asset(
        img,
        width: ScreenUtil().setWidth(size),
        height: ScreenUtil().setWidth(size),
      ),
    );
  }
}
