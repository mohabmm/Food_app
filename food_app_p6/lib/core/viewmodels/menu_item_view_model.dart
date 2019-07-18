import 'dart:async';

import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/models/menuitems.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/service_locator.dart';
import 'package:meta/meta.dart';

import 'base_model.dart';

class MenuItemViewModel extends BaseModel {
  FirebaseService _firebaseService = locator<FirebaseService>();

  MenuItems menuItems = locator<MenuItems>();

// MenuItems
  List<MenuItems> menu;

  StreamSubscription subscription;

  MenuItemViewModel() {
    subscription = _firebaseService.menuItems.listen(_onStatsUp);
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    print("dispose function menu item view model is called");

    print(
        "dispose function  of menu item view model is called after cancel is called finallly");
  }

  void getmenuitemsmodel({@required String menuid}) {
    _firebaseService.getmenuitems(menuid: menuid);
  }

  int _count = 1;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  int calculateTotalPrice(int quantity, int price) {
    int total_price = quantity * price;
    return total_price;
  }

  void decrement() {
    if (count == 0) {
      print("cant decrease more than that ");
    } else {
      _count--;
      notifyListeners();
    }
  }

  void _onStatsUp(List<MenuItems> menus) {
    print(
        "inside the function of menu item view model to gets stats after the constructor");
    menu = menus;

    if (menu == null) {
      setState(ViewState.Busy);

      print("the state is busy as the menu is null");
      // If null indicate we're still fetching
    } else {
      print("now this shouldnt be null it has data");
      print("the menu data is " + menu.toString());
      print("the menu length is " + menu.length.toString());
      setState(ViewState.DataFetched);

      print("the state is dtafetched as the menu is not  null");
      // When not null indicate that the data is fetched
    }
  }
}
