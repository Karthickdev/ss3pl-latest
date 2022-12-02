import 'package:flutter/foundation.dart';

abstract class DefaultChangeNotifier extends ChangeNotifier {
  bool loading = false;
  bool isLoad = true;
  String? errorMessage;

  // ignore: avoid_positional_boolean_parameters
  void toggleLoadingOn(bool on) {
    loading = on;
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleLoad(bool on) {
    isLoad = on;
    notifyListeners();
  }

  void setErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }
}
