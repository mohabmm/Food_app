import 'package:flutter/material.dart';
import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/models/FoodModel.dart';
import 'package:foodaapp/core/services/firebase_service.dart';
import 'package:foodaapp/core/viewmodels/cart_item_view_model.dart';

import '../../service_locator.dart';
import 'base_widget.dart';

class CartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CartItemViewModel>(
        model: CartItemViewModel(),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(context, model)));
  }

  Widget _getBodyUi(BuildContext context, CartItemViewModel model) {
    print("get body UI OF THE HOME VIEW ");
    switch (model.state) {
      case ViewState.Busy:
        return _getLoadingUi(context);
      case ViewState.NoDataAvailable:
        return _noDataUi(context, model);
      case ViewState.Error:
        return _errorUi(context, model);
      case ViewState.DataFetched:
      default:
        return _getListUi(model);
    }
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, CartItemViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, CartItemViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, CartItemViewModel model,
      {bool error = false}) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                error
                    ? Icon(
                        // WWrap in gesture detector and call you refresh future here
                        Icons.refresh,
                        color: Colors.white,
                        size: 45.0,
                      )
                    : Container()
              ],
            )));
  }
}

Widget _getListUi(CartItemViewModel model) {
  ;
  FirebaseService firebaseservice = locator<FirebaseService>();

  return new Scaffold(
      floatingActionButton: new RawMaterialButton(
          child: new Icon(Icons.shopping_cart),
          onPressed: () {
            firebaseservice.deleteAll();
          }),
      appBar: new AppBar(
        title: new Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 450.0,
            child: ListView.builder(
              itemCount: model.food.length,
              itemBuilder: (BuildContext context, int index) {
                Food item = model.food[index];
                int onetypeproductprice = item.price;
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    firebaseservice.delete(item.id);
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.foodName,
                                  style: TextStyle(color: Colors.red)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(onetypeproductprice.toString(),
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          new Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: new Text(model.calulateTotalFoodPrices().toString(),
                  style: TextStyle(fontSize: 40.0, color: Colors.greenAccent)),
            ),
          ),
        ],
      ));
}
