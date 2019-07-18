import 'dart:async';

import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/models/FoodModel.dart';
import 'package:foodaapp/core/models/category.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/service_locator.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  FirebaseService _firebaseService = locator<FirebaseService>();
  List<Food> food;

  List<Category> category;
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

  HomeViewModel() {
    subscription = _firebaseService.categoryFood.listen(_onStatsUpdateds);
    // _firebaseService.foods.listen(_onfoodupdated);
    print("constructor home view model");
  }

  void _onStatsUpdateds(List<Category> categories) {
    print(
        "inside the function of home view model to get stats after constructor ");
    category = categories; // Set the stats for the UI

    if (category == null) {
      setState(ViewState.Error); // If null indicate we're still fetching
    } else if (category.length == null || category.length == 0) {
      setState(ViewState.NoDataAvailable);
    } else if (categories.length == 0) {
      setState(ViewState.Error);
    } else {
      setState(ViewState.DataFetched);
    }
  }
}
