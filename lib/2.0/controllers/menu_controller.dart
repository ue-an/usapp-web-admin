import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isClicked = false;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  bool get isClicked => _isClicked;

  void controlMenu() {
    if (!_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openDrawer();
    }
  }

  set isClicked(bool isClicked) {
    _isClicked = isClicked;
    notifyListeners();
  }

  void openDrawer(BuildContext context) {
    if (_isClicked == true) {
      Scaffold.of(context).openDrawer();
    }
  }
}
