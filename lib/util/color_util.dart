import 'dart:ui';

import 'package:flutter/material.dart';

/// 颜色创建方法
/// - [colorString] 颜色值
/// - [alpha] 透明度(默认1，0-1)
///
/// 可以输入多种格式的颜色代码，如: 0x000000,0xff000000,#000000
Color parseColor(String colorString, {double alpha = 1.0}) {
  if (colorString?.isEmpty ?? true) {
    return Colors.transparent;
  }
  String colorStr = colorString.toLowerCase();
  if (colorStr.startsWith('#')) {
    colorStr = colorStr.replaceRange(0, 1, '0xff');
  }
// 先分别获取色值的RGB通道
  Color color = Color(int.parse(colorStr));
  int red = color.red;
  int green = color.green;
  int blue = color.blue;
// 通过fromRGBO返回带透明度和RGB值的颜色
  return Color.fromRGBO(red, green, blue, alpha);
}
