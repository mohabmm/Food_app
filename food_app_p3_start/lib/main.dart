import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_p3_start/service_locator.dart';
import 'package:food_app_p3_start/ui/views/home_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: HomeView(),
    );
  }
}
// Structuring details :

//
//Models: Contains all the plain data models
//Services: Contains the dedicated files that will handle actual business logic
//ViewModels: Contains the Provider models for each of the Widget views

//Shared: Contains files used in multiple other UI files
//Views: Contains the files for the app views
//Widgets: Contains widget files that are too big to keep in the view files.

//In software engineering, a design pattern is a general repeatable solution to a commonly occurring problem in software design
