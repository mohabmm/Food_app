import 'package:flutter/material.dart';
import 'package:foodaapp/core/enums/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Busy;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
