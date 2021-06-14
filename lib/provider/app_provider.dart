import 'package:flutter/material.dart';

// class AppProvider with ChangeNotifier {
//   List<Product> _featureproducts = [];
//   ProductService _productServices = ProductService();

//   AppProvider() {
//     _getFeaturedProducts();
//   }

//   //getter
//   List<Product> get featureProducts => _featureproducts;

//   //methods
//   void _getFeaturedProducts() async {
//     _featureproducts = await _productServices.getFeaturedProducts();
//     notifyListeners();
//   }
// }

class AppProvider with ChangeNotifier {
  bool isLoading = false;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
