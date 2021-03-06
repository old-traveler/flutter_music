import 'package:flutter/material.dart';
import 'package:music/util/screenutil.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String img;
  final double size;
  final VoidCallback onTap;

  BackgroundImageWidget(this.img, this.size, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(size / 5),
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(30)),
        child: Image.asset(
          img,
          width: ScreenUtil().setWidth(size),
          height: ScreenUtil().setWidth(size),
        ),
      ),
      onTap: onTap,
    );
  }
}
