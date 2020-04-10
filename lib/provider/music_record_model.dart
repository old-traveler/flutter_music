import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicRecordModel with ChangeNotifier {
  List<String> _searchHistory;

  Future initSearchHistory() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _searchHistory = sp.getStringList('_searchHistory') ?? [];
    notifyListeners();
    print('initSearchHistory');
  }

  List<String> get searchHistory => _searchHistory;

  void addSearchHistory(String keyWord) {
    _searchHistory.remove(keyWord);
    _searchHistory.insert(0, keyWord);
    if (_searchHistory.length > 15) {
      _searchHistory.removeLast();
    }
    _updateCacheAndNotify();
  }

  void removeSearchHistory(String keyWord) {
    _searchHistory.remove(keyWord);
    _updateCacheAndNotify();
  }

  void _updateCacheAndNotify() async {
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('_searchHistory', _searchHistory);
  }
}
