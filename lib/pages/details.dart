import 'package:avadanlik/commons/common.dart';
import 'package:avadanlik/commons/loading.dart';
import 'package:avadanlik/models/product.dart';
import 'package:avadanlik/pages/cart.dart';
import 'package:avadanlik/provider/app_provider.dart';
import 'package:avadanlik/provider/user_provider.dart';
import 'package:avadanlik/widgets/custom_text.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//import 'package:transparent_image/transparent_image.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: appProvider.isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.product.picture),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: widget.product.name,
                      size: 26,
                      weight: FontWeight.bold),
                  CustomText(
                      text: "\₺${widget.product.rent}",
                      size: 20,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(text: "Detay", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: IconButton(
                      //       icon: Icon(
                      //         Icons.remove,
                      //         size: 36,
                      //       ),
                      //       onPressed: () {
                      //         if (quantity != 1) {
                      //           setState(() {
                      //             quantity -= 1;
                      //           });
                      //         }
                      //       }),
                      // ),
                      GestureDetector(
                        onTap: () async {
                          appProvider.changeIsLoading();
                          print("Her şey yükleniyor...");

                          bool value = await userProvider.addToCart(
                              product: widget.product);
                          if (value) {
                            print("Sepete Eklendi!");
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("Sepete Eklendi!")));
                            userProvider.reloadUserModel();
                            appProvider.changeIsLoading();
                            return;
                          } else {
                            print("Sepete Eklenemedi");
                          }
                          print("YÜKLENEMİYOR");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: deepOrange,
                              borderRadius: BorderRadius.circular(20)),
                          child: appProvider.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Sepete Ekle",
                                    color: white,
                                    size: 22,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: IconButton(
                      //       icon: Icon(
                      //         Icons.add,
                      //         size: 36,
                      //         color: Colors.red,
                      //       ),
                      //       onPressed: () {
                      //         setState(() {
                      //           quantity += 1;
                      //         });
                      //       }),
                      // ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
