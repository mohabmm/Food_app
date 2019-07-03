import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}

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

//  Widget _noDataUi(BuildContext context, HomeViewModel model) {
//    return _getCenteredViewMessage(context, "No data available yet", model);
//  }
//
//  Widget _errorUi(BuildContext context, HomeViewModel model) {
//    return _getCenteredViewMessage(
//        context, "Error retrieving your data. Tap to try again", model,
//        error: true);
//  }
//
//  Widget _getCenteredViewMessage(
//      BuildContext context, String message, HomeViewModel model,
//      {bool error = false}) {
//    return Center(
//        child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20.0),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Text(
//                  message,
//                  textAlign: TextAlign.center,
//                ),
//                error
//                    ? Icon(
//                        // WWrap in gesture detector and call you refresh future here
//                        Icons.refresh,
//                        color: Colors.white,
//                        size: 45.0,
//                      )
//                    : Container()
//              ],
//            )));
//  }
//
//
//  Widget _getListUi(HomeViewModel model) {
//    return new ListView.builder(
//        itemExtent: 220.0,
//        itemCount: model.category.length,
//        itemBuilder: (BuildContext context, int index) {
//          String image = model.category[index].image;
//          String name = model.category[index].name;
//          return Column(
//            children: <Widget>[
//              new Image.network(
//                image,
//                fit: BoxFit.fill,
//                height: 201.0,
//                width: double.infinity,
//              ),
//              new Text(
//                name,
//              ),
//            ],
//          );
//        });
//  }
}
