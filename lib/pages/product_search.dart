import 'package:avadanlik/commons/common.dart';
import 'package:avadanlik/provider/product.dart';
import 'package:avadanlik/pages/product_details.dart';
import 'package:avadanlik/widgets/custom_text.dart';
import 'package:avadanlik/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Ürünler",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: () {})
        ],
      ),
      body: productProvider.productSearhed.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "Ürün Bulunamadı",
                      color: Colors.grey,
                      weight: FontWeight.w300,
                      size: 22,
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productSearhed.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          ProductDetails(
                              product: productProvider.productSearhed[index]));
                    },
                    child: ProductCard(
                        product: productProvider.productSearhed[index]));
              }),
    );
  }
}
