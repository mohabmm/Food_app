import 'package:get_it/get_it.dart';

import 'core/services/firebase_service.dart';
import 'core/viewmodels/home_view_model.dart';

/*
* , I use get_it as my service locator to get my objects and services into places where the context is not available.
* */
GetIt locator = new GetIt();

void setupLocator() {
  // Register services
  // i want the firebase service to be in the whole lifecycle of my application (singelton)
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

  //Important note:
  //If there will only ever be one that never gets disposed then a singleton. If not then a factory
}
