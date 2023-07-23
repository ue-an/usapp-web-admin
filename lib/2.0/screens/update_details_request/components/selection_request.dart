import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SelectionRequestProvider with ChangeNotifier {
  bool _haveSelections = false;
  bool get haveSelections => _haveSelections;
  set haveSelections(bool haveSeletions) {
    _haveSelections = haveSeletions;
    notifyListeners();
  }
}
