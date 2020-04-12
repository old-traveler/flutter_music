import 'package:flutter/material.dart';
import 'package:music/main.dart';
import 'package:music/page/music_play_page.dart';
import 'package:music/page/search_page.dart';
import 'package:music/page/search_result_page.dart';
import 'package:music/page/singer_song_list_page.dart';
import 'package:music/page/song_sheet_page.dart';
import 'package:music/page/splash_page.dart';
import 'package:music/page/web_page.dart';

class MusicRouter {
  static Map<String, WidgetBuilder> get routers => {
        'splash': (context) => SplashPage(),
        'main': (context) => MainPage(),
        'search': (context) => SearchPage(),
        'song_sheet': (context) => SongSheetPage(),
        'music_play': (context) => MusicPlayPage(),
      };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name;
    Route<dynamic> _webUrlRoute() => MaterialPageRoute(
        builder: (context) => WebPage(url: settings.arguments));

    Route<dynamic> _searchResultRouter() => MaterialPageRoute(
        builder: (context) => SearchResultPage(keyWord: settings.arguments));

    Route<dynamic> _singerSongRouter() {
      List list = settings.arguments;
      return MaterialPageRoute(
          builder: (context) =>
              SingerSongListPage(singerId: list[0], singerName: list[1]));
    }

    switch (routeName) {
      case 'web':
        return _webUrlRoute();
      case 'search_result':
        return _searchResultRouter();
      case 'singer_song':
        return _singerSongRouter();
    }

    return null;
  }
}
