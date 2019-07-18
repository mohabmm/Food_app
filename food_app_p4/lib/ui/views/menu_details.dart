import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodaapp/core/enums/viewstate.dart';
import 'package:foodaapp/core/viewmodels/menu_item_view_model.dart';

import 'base_widget.dart';

class MenuDetails extends StatelessWidget {
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

  Widget _noDataUi(BuildContext context, MenuItemViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, MenuItemViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, MenuItemViewModel model,
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

  Widget _getBodyUil(BuildContext context, MenuItemViewModel model) {
    print("get body ui of menu details is called ");

    print("the curren model state is" + model.state.toString());

    switch (model.state) {
      case ViewState.Busy:
      case ViewState.Idle:
        print("the state inside the body is of menu details is " +
            model.state.toString());
        return Center(child: CircularProgressIndicator());
      default:
        print("the state inside the body is of menu details is " +
            model.state.toString());
        return _getListUi(model, context);
    }
  }

  Widget _getListUi(MenuItemViewModel model, BuildContext context) {
    return new ListView.builder(
        itemExtent: 220.0,
        itemCount: model.menu.length,
        itemBuilder: (contextl, int index) {
          String image = model.menu[index].Image;
          String name = model.menu[index].Name;

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'itemdetails',
                  arguments: model.menu[index]);
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
