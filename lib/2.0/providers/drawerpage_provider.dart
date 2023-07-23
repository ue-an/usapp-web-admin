import 'package:flutter/material.dart';

class DrawerPageProvider2 with ChangeNotifier {
  int _drawerPageSelected = 0;

  //getter
  int get drawerPageSelected => _drawerPageSelected;

  //setter
  set changeDrawerPageSelected(int drawerPageSelected) {
    _drawerPageSelected = drawerPageSelected;
    notifyListeners();
  }
}
