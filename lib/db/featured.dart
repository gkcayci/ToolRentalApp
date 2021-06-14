import 'dart:async';
import 'package:avadanlik/models/product.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'products';

  Future<List<ProductModel>> getFeaturedProducts() =>
      _firestore.collection(collection).get().then((snap) {
        List<ProductModel> featuredProducts = [];
        snap.docs.map((snapshot) =>
            featuredProducts.add(ProductModel.fromSnapshot(snapshot)));
        return featuredProducts;
      });
}
