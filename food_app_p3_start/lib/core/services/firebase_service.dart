import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app_p3_start/core/models/category.dart';

class FirebaseService {
  final StreamController<List<Category>> categoryController =
      StreamController<List<Category>>();

  FirenaseService() {
    Firestore.instance
        .collection('Category')
        .snapshots()
        .listen(_feedbackAdded);
  }

  void _feedbackAdded(QuerySnapshot snapShot) {
    // in this line i have list of category
    var category = _getCategoryFromSnapshot(snapShot);
    categoryController.add(category);
  }

  Stream<List<Category>> get categoryFood => categoryController.stream;

  // Helper function that Converts a QuerySnapshot into a List<Cartegory>
  _getCategoryFromSnapshot(QuerySnapshot snapShot) {
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
