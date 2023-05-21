import 'package:flutter/cupertino.dart';

class PageIndexProvider extends ChangeNotifier {
  int pIndex = 1;

  void indexUpdater(int index) {
    pIndex = index;
    notifyListeners();
  }
}
