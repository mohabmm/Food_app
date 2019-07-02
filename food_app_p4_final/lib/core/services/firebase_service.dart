import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodaapp/core/models/category.dart';
import 'package:foodaapp/core/models/menuitems.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';


class FirebaseService {
  StreamController<List<Category>> categoryController =
      StreamController<List<Category>>();

//   the BehaviorSubject also sends the very last event
//  that was emitted to the listener that just subscribed
  StreamController<List<MenuItems>> menuItemsController = new BehaviorSubject();
  Stream<List<Category>> get categoryFood => categoryController.stream;
  Stream<List<MenuItems>> get menuItems => menuItemsController.stream;

  FirebaseService() {
    // used to call the main collection food caegory
    Firestore.instance
        .collection('Category')
        .snapshots()
        .listen(_feedbackAdded);
  }

  void getmenuitems({@required String menuid}) {
    Firestore.instance
        .collection('Food')
        .where('MenuId', isEqualTo: int.parse(menuid))
        .snapshots()
        .listen(_menuitemsUpdated);
    print("a7a get meny item updated called");
  }

  void _menuitemsUpdated(QuerySnapshot snapshot) {
    var item = _getMenuFromSnapshot(snapshot);

    menuItemsController.add(item);
  }

  void _feedbackAdded(QuerySnapshot snapShot) {
    var category = _getCategoryFromSnapshot(snapShot);
    categoryController.add(category);
  }

  List<MenuItems> _getMenuFromSnapshot(QuerySnapshot snapshot) {
    var menuItems = List<MenuItems>();
    var documents = snapshot.documents;

    var hasDocuments = documents.length > 0;

    if (hasDocuments) {
      for (var document in documents) {
        menuItems.add(MenuItems.fromSnapshot(document.data));
      }
    }

    print(" menu item length is " + menuItems.length.toString());

    return menuItems;
  }

  // Helper function that Converts a QuerySnapshot into a List<Stats>
  List<Category> _getCategoryFromSnapshot(QuerySnapshot snapShot) {
    var categoryItems = List<Category>();
    var documents = snapShot.documents;
    var hasDocuments = documents.length > 0;
    if (hasDocuments) {
      for (var document in documents) {
        categoryItems.add(Category.fromSnapshot(document.data));
      }
    }
    print("category items length is " + categoryItems.length.toString());
    return categoryItems;
  }
}
