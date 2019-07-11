import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/viewmodels/home_view_model.dart';
import 'package:foodaapp/core/viewmodels/menu_item_view_model.dart';

import '../../service_locator.dart';
import 'base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(context, model)));
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

  Widget _noDataUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, HomeViewModel model,
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

  Widget _getBodyUi(BuildContext context, HomeViewModel model) {
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

  Widget _getListUi(HomeViewModel model) {
    return new ListView.builder(
        itemExtent: 220.0,
        itemCount: model.category.length,
        itemBuilder: (BuildContext context, int index) {
          String image = model.category[index].image;
          String name = model.category[index].name;

          return GestureDetector(
            onTap: () {
              MenuItemViewModel menuitemviewmodel =
                  locator<MenuItemViewModel>();

              menuitemviewmodel.getmenuitemsmodel(menuid: index.toString());

              Navigator.pushNamed(context, 'menudetails');
            },
            child: Column(
              children: <Widget>[
                new Image.network(
                  image,
                  fit: BoxFit.fill,
                  height: 201.0,
                  width: double.infinity,
                ),
                new Text(
                  name,
                ),
              ],
            ),
          );
        });
  }
}
