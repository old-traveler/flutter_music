import 'package:flutter/cupertino.dart';

class TabIndex extends ChangeNotifier {
  int _curIndex = 0;
  List<Widget> child;

  TabIndex(this._curIndex, this.child);

  get widgets => child;

  get curIndex => _curIndex;

  void changeIndex(int index) {
    if (_curIndex != index) {
      _curIndex = index;
      notifyListeners();
    }
  }
}
