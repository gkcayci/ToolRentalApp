import "package:flutter/material.dart";

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnTheCart = [
    {
      "name": "Çim Biçme Makinesi",
      "picture": "images/products/Alpina Benzinli Çim Biçme Makinesi.jpg",
      "rent_price": 53.19,
      "piece": 1,
      "day": "3"
    },
    {
      "name": "Teknisyen Takım Çantası ",
      "picture": "images/products/Teknisyen Takım Çantası.jpg",
      "rent_price": 2.3,
      "piece": 2,
      "day": "2"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: productsOnTheCart.length,
        itemBuilder: (context, index) {
          return singleCartProduct(
              cartProdName: productsOnTheCart[index]["name"],
              cartProdPicture: productsOnTheCart[index]["picture"],
              cartProdRentPrice: productsOnTheCart[index]["rent_price"],
              cartProdPiece: productsOnTheCart[index]["piece"],
              cartProdDay: productsOnTheCart[index]["day"]);
        });
  }
}

class singleCartProduct extends StatelessWidget {
  final cartProdName;
  final cartProdPicture;
  final cartProdRentPrice;
  final cartProdPiece;
  final cartProdDay;

  singleCartProduct(
      {this.cartProdName,
      this.cartProdPicture,
      this.cartProdRentPrice,
      this.cartProdPiece,
      this.cartProdDay});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: new Image.asset(
          cartProdPicture,
          width: 80.0,
          height: 80.0,
        ),
        //title
        title: new Text(cartProdName != null ? cartProdName : 'default value'),
        //subtitle
        subtitle: new Column(
          children: <Widget>[
            //Row inside column
            new Row(
              children: <Widget>[
                //This section is for the piece
                // Padding(
                // padding: const EdgeInsets.all(0),
                //child: new Text("Adet:"),
                // ),
                // Padding(
                // padding: const EdgeInsets.all(4),
                //child: new Text(
                //cartProdQty,
                //style: TextStyle(color: Colors.black),
                //),
                //),

                // Rental Day
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new Text("Gün:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: new Text(
                    cartProdDay,
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),

            //Rental Price
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("\₺${cartProdRentPrice}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
            )
          ],
        ),
        trailing: new Column(
          children: <Widget>[
            Expanded(child: Icon(Icons.arrow_drop_up)),
            new Text("${cartProdPiece}"),
            Expanded(child: Icon(Icons.arrow_drop_down)),
          ],
        ),
      ),
    );
  }
}
