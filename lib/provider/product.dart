import 'package:avadanlik/models/product.dart';
import 'package:avadanlik/db/products.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productService = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productSearhed = [];
  List<ProductModel> productsByCategory = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productService.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productService.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future search({String productName}) async {
    productSearhed =
        await _productService.searchProducts(productName: productName);
    notifyListeners();
  }
}
