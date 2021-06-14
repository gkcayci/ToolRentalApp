import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const NAME = "category";
  static const IMAGE = "image";

  int _id;
  String _category;
  String _image;

  //  getters
  int get id => _id;

  String get name => _category;

  String get image => _image;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _category = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
  }
}
