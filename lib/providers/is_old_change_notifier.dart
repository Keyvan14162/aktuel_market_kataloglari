import 'package:flutter/widgets.dart';

class IsOldNotifier extends ChangeNotifier {
  bool _isOld = false;

  bool get isOld => _isOld;

  void changeIsOld({required bool isOld}) {
    _isOld = isOld;
    notifyListeners();
  }
}
