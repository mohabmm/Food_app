import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodaapp/core/models/FoodModel.dart';
import 'package:foodaapp/core/models/menuitems.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/core/viewmodels/menu_item_view_model.dart';

import '../../service_locator.dart';
import 'base_widget.dart';

class ItemDetails extends StatelessWidget {
  MenuItems menuitems;
  ItemDetails({this.menuitems});
  @override
  Widget build(BuildContext context) {
    return BaseWidget<MenuItemViewModel>(
        model: MenuItemViewModel(),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUil(context, model)));
  }

  Widget _getBodyUil(BuildContext context, MenuItemViewModel model) {
    print("get body UI OF THE HOME VIEW ");

    return _getListUi(model);
  }

  Widget _getListUi(MenuItemViewModel model) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(menuitems.Name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  collapseMode: CollapseMode.parallax,
                  background: Image.network(
                    menuitems.Image,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: double.infinity,
                  child: new Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            menuitems.Name,
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 10.0,
                                ),
                                new Text(
                                  "\$",
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  width: 14.0,
                                ),
                                new Text(
                                  model
                                      .calculateTotalPrice(model.count,
                                          int.parse(menuitems.Price))
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: new Container(
                              width: 104.0,
                              height: 30.0,
                              color: Colors.green,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new IconButton(
                                      icon: new Icon(Icons.minimize),
                                      onPressed: () {
                                        model.decrement();
                                      }),
                                  new Text('${model.count}'),
                                  new IconButton(
                                      icon: new Icon(Icons.add),
                                      onPressed: () {
                                        model.increment();
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                (menuitems.Description != null && menuitems.Description != "")
                    ? Container(
                        height: 70.0,
                        width: double.infinity,
                        child: new Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: new Text(
                                menuitems.Description,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      )
                    : new Container(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Food food = new Food(
            id: int.parse(menuitems.Id),
            foodName: menuitems.Name,
            price: model.calculateTotalPrice(
                model.count, int.parse(menuitems.Price)),
//              total: model.calculateTotalPrice(
//                  model.count, int.parse(menuitems.Price))
          );
          FirebaseService firebaseservice = locator<FirebaseService>();
          firebaseservice.add(food);
          print("food added ");
          Fluttertoast.showToast(
              msg: "food added ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: new Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
