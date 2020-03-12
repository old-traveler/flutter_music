

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("首页"),
    );
  }

}

class TypePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TypePageState();
  }
}

class TypePageState extends State<TypePage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("分类"),
    );
  }

}


class RankPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RankPageState();
  }

}

class RankPageState extends State<RankPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("排行榜"),
    );
  }
}


class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }

}

class MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("我的"),
    );
  }
}