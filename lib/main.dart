import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music/page/home_page.dart';
import 'package:music/page/hot_singer_page.dart';
import 'package:music/page/live_page.dart';
import 'package:music/page/my_profile_page.dart';
import 'package:music/page/search_page.dart';
import 'package:music/page/splash_page.dart';
import 'package:music/provider/play_songs_model.dart';
import 'package:provider/provider.dart';

import 'components/music_home_widget.dart';

void main() => runApp(MusicApp());

class MusicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlaySongsModel()..init(),
        )
      ],
      child: MaterialApp(
          title: 'Music',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  final List<Widget> _tabViews = [
    HomePage(),
    LivePage(),
    HotSingerPage(),
    MyProfilePage(),
  ];

  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.music_note),
      title: Text("音乐"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      title: Text("直播"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.equalizer),
      title: Text("排行榜"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      title: Text("我的"),
    )
  ];

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  PageController _pageController;
  int _curIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: _buildAppBar(),
        body: PageView(
          controller: _pageController,
          children: widget._tabViews,
          onPageChanged: (index) {
            setState(() => _curIndex = index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() => _curIndex = index);
              _pageController.jumpToPage(index);
            },
            currentIndex: _curIndex,
            fixedColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: widget._barItems));
  }

  Widget _buildAppBar() {
    List<Widget> actions = [
      IconButton(
        icon: Icon(Icons.search),
        tooltip: 'search',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchPage()));
        },
      )
    ];
    return AppBar(
      title: Text("Music"),
      leading: MusicHomeWidget(),
      actions: actions,
    );
  }
}
