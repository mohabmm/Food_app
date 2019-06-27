import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/models/category.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/service_locator.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  FirebaseService _firebaseService = locator<FirebaseService>();

  List<Category> category;

//  var request1;
  HomeViewModel() {
    _firebaseService.categoryFood.listen(_onStatsUpdateds);
  }

  void _onStatsUpdateds(List<Category> categories) {
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
//
//  void dispose() {
//    super.dispose();
//    request1.cancel();
//  }
}
