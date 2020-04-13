import 'dart:ui';

import 'package:flutter/material.dart';

/// 矩形高斯模糊效果
class BlurRectWidget extends StatefulWidget {
  final Widget child;

  /// 模糊值
  final double sigmaX;
  final double sigmaY;

  const BlurRectWidget({
    Key key,
    this.child,
    this.sigmaX,
    this.sigmaY,
  }) : super(key: key);

  @override
  _BlurRectWidgetState createState() => _BlurRectWidgetState();
}

class _BlurRectWidgetState extends State<BlurRectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: this.widget.sigmaX != null ? this.widget.sigmaX : 4,
          sigmaY: this.widget.sigmaY != null ? this.widget.sigmaY : 4,
        ),
        child: Container(
          color: Colors.black26,
          child: this.widget.child,
        ),
      ),
    );
  }
}
