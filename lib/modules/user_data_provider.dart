import 'package:diamond/modules/user_data.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  void setUserData(UserData data) {
    _userData = data;
    notifyListeners();
  }
}
