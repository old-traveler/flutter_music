import 'package:flutter/material.dart';
import 'package:music/page/home_page.dart';
import 'package:music/provider/navigation_index.dart';
import 'package:provider/provider.dart';

void main() => runApp(MusicApp());

class MusicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              TabIndex(0, [HomePage(), TypePage(), RankPage(), MyPage()]),
        )
      ],
      child: MaterialApp(
          title: 'Music',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  PageController _pageController;
  TabIndex _tabIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    _tabIndex = Provider.of<TabIndex>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        leading: Icon(Icons.music_note),
      ),
      body: PageView(
        controller: _pageController,
        children: _tabIndex.widgets,
        onPageChanged: (index) {
          _tabIndex.changeIndex(index);
        },
      ),
      bottomNavigationBar: Consumer<TabIndex>(
        builder: (BuildContext context, TabIndex tabIndex, _) {
          return BottomNavigationBar(
            onTap: (index) {
              tabIndex.changeIndex(index);
              _pageController.jumpToPage(index);
            },
            currentIndex: tabIndex.curIndex,
            fixedColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.music_note), title: Text("音乐")),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text("分类"),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.equalizer), title: Text("排行榜")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), title: Text("我的"))
            ],
          );
        },
      ),
    );
  }
}
