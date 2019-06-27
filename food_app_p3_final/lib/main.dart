import 'package:flutter/material.dart';
import 'package:foodaapp/service_locator.dart';
import 'package:foodaapp/ui/views/home_view.dart';

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
