import 'package:avadanlik/commons/common.dart';
import 'package:avadanlik/models/product.dart';
import 'package:avadanlik/pages/product_details.dart';
import 'package:avadanlik/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../commons/loading.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          changeScreen(
              context,
              ProductDetails(
                product: product,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: product.picture,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 260,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '${product.name} \n',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextSpan(
                      text: 'Üretici: ${product.brand} \n\n\n\n',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    TextSpan(
                      text: '\₺${product.rent} \t',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // TextSpan(
                    //   text: product.sale != null ? 'ON SALE ' : "",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w400,
                    //       color: Colors.deepOrange),
                    // ),
                  ], style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _productImage(String picture) {
    if (picture == null) {
      return Container(
        child: CustomText(text: "No Image"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.picture,
            height: 140,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
