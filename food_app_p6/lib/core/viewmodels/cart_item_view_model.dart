import 'dart:async';

import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/models/FoodModel.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/service_locator.dart';

import 'base_model.dart';

class CartItemViewModel extends BaseModel {
  FirebaseService _firebaseService = locator<FirebaseService>();

  List<Food> food;
  StreamSubscription subscription;

  CartItemViewModel() {
    subscription = _firebaseService.foods.listen(_onfoodupdated);
    print("constructor home view model");
  }

  int _totalprice = 0;
  int get totalprice => _totalprice;

  void _onfoodupdated(List<Food> foods) {
    print(
        "inside the the cart item model function of home view model to get stats after constructor ");
    food = foods; // Set the stats for the UI

    if (food == null) {
      print("the food  the cart item modelis null so the state hs error");
      setState(ViewState.Error); // If null indicate we're still fetching
    } else if (food.length == null || food.length == 0) {
      print(
          "the food  the cart item model length is  0 or the food length is null ");
      setState(ViewState.NoDataAvailable);
    } else if (foods.length == 0) {
      print("the food the cart item model  length is 0");
      setState(ViewState.Error);
    } else {
      print("the data of the cart item model is fetched");
      setState(ViewState.DataFetched);
    }
  }

  calulateTotalFoodPrices() {
    print("the current food length is " + food.length.toString());
    _totalprice = 0;
    if (food != null) {
      for (int i = 0; i < food.length; i++) {
        _totalprice += food[i].price;
      }
      if (food.length == 0) {
        _totalprice = 0;
      }
      notifyListeners();
      return _totalprice ?? 0;
    }
  }
}
