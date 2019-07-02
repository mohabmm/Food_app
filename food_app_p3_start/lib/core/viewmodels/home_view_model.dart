import 'package:food_app_p3_start/core/enums/viewstate.dart';
import 'package:food_app_p3_start/core/models/category.dart';
import 'package:food_app_p3_start/core/services/firebase_service.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  FirebaseService _firebaseService = locator<FirebaseService>();
  List<Category> category;

  HomeViewModel() {
    _firebaseService.categoryFood.listen(_onStatsUpdateds);
  }

  void _onStatsUpdateds(List<Category> categories) {
    category = categories; // Set the stats for the UI

    if (category == null) {
      setState(ViewState.Error); // If null indicate we're still fetching
    } else if (category.length == null || category.length == 0) {
      setState(ViewState.NoDataAvailable);
    } else {
      setState(ViewState.DataFetched);
    }
  }
}
