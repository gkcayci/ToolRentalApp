import 'package:flutter/material.dart';

// my imports
import 'package:avadanlik/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Sepet'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: new CartProducts(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text("Toplam:"),
              subtitle: new Text("\₺230"),
            )),
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                child: new Text(
                  "Ödeme",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
