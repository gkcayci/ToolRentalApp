import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  //  constants
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  //static const String COLORS = 'colors';
  static const FEATURED = 'featured';
  static const ID = 'id';
  static const NAME = 'name';
  static const PICTURE = 'picture';
  //static const PRICE = 'price';
  static const RENT = 'rent'; // kira

  //static const AVAILABLEDAYS = 'availabledays'; //gün
  static const SALE = 'sale'; //sale = liste fiyatı
  static const DESCRIPTION = "description";
  static const TECHNICALSPECIFICATIONS = "technicalSpecifications";

  //static const String SIZE = 'size';

  //  private variables
  String _brand;
  String _category;
  String _imageUrl;
  String _id;
  String _name;
  String _picture;
  String _description;
  String _technicalSpecifications;
  //double _price;
  num _rent;
  num _quantity;
  // List<String> _colors;
  // List<String> _size;
  bool _featured;
  num _sale;

  //  getters
  String get brand => _brand;
  String get imageUrl => _imageUrl;
  String get category => _category;
  String get description => _description;
  String get id => _id;
  String get name => _name;
  String get picture => _picture;
  String get technicalSpecifications => _technicalSpecifications;
  //double get price => _price;
  num get rent => _rent;
  num get quantity => _quantity;
  // List<String> get colors => _colors;
  // List<String> get size => _size;
  bool get featured => _featured;
  double get sale => _sale;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _brand = snapshot.data()[BRAND];
    _sale = snapshot.data()[SALE];
    // _description = snapshot.data()[DESCRIPTION] ?? " ";
    _featured = snapshot.data()[FEATURED];
    _description = snapshot.data()[DESCRIPTION];
    _technicalSpecifications = snapshot.data()[TECHNICALSPECIFICATIONS];

    ///_price = snapshot.data()PRICE].floor();
    _rent = snapshot.data()[RENT];
    _category = snapshot.data()[CATEGORY];
    // _colors = snapshot.data()[COLORS];
    // _sizes = snapshot.data()[SIZES];
    _name = snapshot.data()[NAME];
    _picture = snapshot.data()[PICTURE];
  }
}
