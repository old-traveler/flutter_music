import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyProfileState();
}

class MyProfileBloc extends BaseBloc {}

class MyProfileState extends State<MyProfilePage> {
  MyProfileBloc _myProfileBloc = MyProfileBloc();

  @override
  Widget build(BuildContext context) {
    return InheritedProvider.value(
        value: _myProfileBloc.streamManager,
        updateShouldNotify: (o, n) => false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    'images/default_image.png',
                    width: 60,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '点击登录，享精准歌曲推荐',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.mic_none),
                    ),
                  )
                ],
              ),
              RibbonWidget(),
            ],
          ),
        ));
  }
}

class RibbonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 165,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular((10.0))),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Image.asset(
                'images/vip.png',
                width: 21,
              ),
              SizedBox(width: 5),
              Text(
                '会员中心',
                style: TextStyle(
                    color: Color(0xffD7AF77), fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '会员享受付费库下载特权',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 15,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Divider(
              height: 1,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildItem(),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  List<Widget> _buildItem() {
    List<Widget> widgets = [];
    final list = <ProfileItem>[
      ProfileItem('images/duv.png', '本地', '0'),
      ProfileItem('images/dux.png', '收藏', '0'),
      ProfileItem('images/duz.png', '下载', '0'),
      ProfileItem('images/dv4.png', '云盘', '0'),
      ProfileItem('images/dv6.png', '最近', '0'),
    ];
    for (var value in list) {
      widgets.add(Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              value.assetUrl,
              width: 40,
              height: 40,
            ),
            Text(
              value.name,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              value.count,
              style: TextStyle(color: Colors.black38),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}

class ProfileItem {
  String assetUrl;
  String name;
  String count;

  ProfileItem(this.assetUrl, this.name, this.count);
}
