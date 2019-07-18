import 'package:flutter/material.dart';
import 'package:foodaapp/core/models/menuitems.dart';

class ItemDetails extends StatelessWidget {
  MenuItems menuItemViewModel;
  ItemDetails({this.menuItemViewModel});
  @override
  Widget build(BuildContext context) {
//    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

//    int ids = int.parse(id);

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
                  title: Text(menuItemViewModel.Name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  collapseMode: CollapseMode.parallax,
                  background: Image.network(
                    menuItemViewModel.Image,
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
                            menuItemViewModel.Name,
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
                                  menuItemViewModel.Price,
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
                                      onPressed: () {}),
                                  new Text("0"),
                                  new IconButton(
                                      icon: new Icon(Icons.add),
                                      onPressed: () {
//                                        Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                                builder: (context) =>
//                                                    CartItems()));
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
                (menuItemViewModel.Description != null &&
                        menuItemViewModel.Description != "")
                    ? Container(
                        height: 70.0,
                        width: double.infinity,
                        child: new Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: new Text(
                                menuItemViewModel.Description,
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
//          Food food = new Food(
//              id: ids, foodName: name, price: int.parse(price), total: 0);
//          cartBloc.add(food);
        },
        child: new Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
