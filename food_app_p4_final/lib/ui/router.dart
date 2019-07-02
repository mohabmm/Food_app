import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodaapp/ui/views/home_view.dart';
import 'package:foodaapp/ui/views/menu_details.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'menudetails':
        return MaterialPageRoute(builder: (_) => MenuDetails());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
