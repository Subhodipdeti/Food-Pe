import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  var _user;
  var _address;

  get userDetails {
    return _user;
  }

  get userAddress {
    return _address;
  }

  void setUser(user) {
    _user = user;
    notifyListeners();
  }

  void setAddress(address) {
    _address = address;
    notifyListeners();
  }
}
