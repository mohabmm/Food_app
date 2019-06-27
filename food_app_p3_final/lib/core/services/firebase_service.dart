import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodaapp/core/models/category.dart';

class FirebaseService {
  final StreamController<List<Category>> categoryController =
      StreamController<List<Category>>();

  FirebaseService() {
    Firestore.instance
        .collection('Category')
        .snapshots()
        .listen(_feedbackAdded);
  }

  Stream<List<Category>> get categoryFood => categoryController.stream;

  void _feedbackAdded(QuerySnapshot snapShot) {
    var category = _getCategoryFromSnapshot(snapShot);
    categoryController.add(category);
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
    return categoryItems;
  }
}
