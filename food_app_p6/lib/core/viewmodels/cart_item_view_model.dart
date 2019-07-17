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

  @override
  void dispose() {
    print("dispose function is called");
    try {
      subscription.cancel();
      print("dispose function is called after cancel is called");
    } catch (exception, stackTrace) {
      print("the exception is " + exception.toString());
    } finally {
      super.dispose();
    }
  }

  CartItemViewModel() {
    subscription = _firebaseService.foods.listen(_onfoodupdated);
    print("constructor home view model");
  }

  calulateTotalFoodPrices(var price) {
    int sum;
    for (int i = 0; i < price.length; i++) {
      sum += price[i];
    }

    print("total price is " + sum.toString());
    notifyListeners();
    return sum;
  }

  void _onfoodupdated(List<Food> foods) {
    print(
        "inside the function of home view model to get stats after constructor ");
    food = foods; // Set the stats for the UI

    if (food == null) {
      setState(ViewState.Error); // If null indicate we're still fetching
    } else if (food.length == null || food.length == 0) {
      setState(ViewState.NoDataAvailable);
    } else if (foods.length == 0) {
      setState(ViewState.Error);
    } else {
      setState(ViewState.DataFetched);
    }
  }
}
