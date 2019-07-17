import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodaapp/core/models/menuitems.dart';
import 'package:foodaapp/ui/views/cart_items.dart';
import 'package:foodaapp/ui/views/home_view.dart';
import 'package:foodaapp/ui/views/item_details.dart';
import 'package:foodaapp/ui/views/menu_details.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'menudetails':
        return MaterialPageRoute(builder: (_) => MenuDetails());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'cartitems':
        return MaterialPageRoute(builder: (_) => CartItems());

      case 'itemdetails':
        var menuitemmodel = settings.arguments as MenuItems;

        return MaterialPageRoute(
            builder: (_) => ItemDetails(
                  menuitems: menuitemmodel,
                ));

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
