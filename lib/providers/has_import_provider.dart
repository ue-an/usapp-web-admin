import 'package:flutter/material.dart';

class HasImportProvider with ChangeNotifier {
  bool _hasImport = false;

  //get
  bool get hasImport => _hasImport;

  //set
  set changeHasImport(bool hasImport) {
    _hasImport = hasImport;
    notifyListeners();
  }
}
