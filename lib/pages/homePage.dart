import 'package:avadanlik/components/HorizantalListView.dart';
import 'package:avadanlik/components/products.dart';
import 'package:avadanlik/pages/cart.dart';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/r1.jpg'),
          AssetImage('images/r3.jpeg'),
          AssetImage('images/r2.jpg'),
          AssetImage('images/r4.jpg'),
          AssetImage('images/r5.jpg'),
          AssetImage('images/r6.jpg'),
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        dotBgColor: Colors.transparent,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Avadanlık'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('avadanlik@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.deepOrange),
            ),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Ana Sayfa'),
                    leading: Icon(Icons.home, color: Colors.grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Hesabım'),
                    leading: Icon(Icons.person, color: Colors.grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Kiraladıklarım'),
                    leading: Icon(Icons.shopping_basket, color: Colors.grey))),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart()));
                },
                child: ListTile(
                    title: Text('Sepetim'),
                    leading: Icon(Icons.shopping_cart, color: Colors.grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Beğendiklerim'),
                    leading: Icon(Icons.favorite, color: Colors.grey))),
            Divider(color: Colors.black),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Ayarlar'),
                    leading: Icon(Icons.settings, color: Colors.grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Hakkımızda'),
                    leading: Icon(Icons.help, color: Colors.grey))),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel starts here
          image_carousel,
          //Padding Widget
          new Padding(
            padding: const EdgeInsets.all(2.0),
            child: new Text('Kategoriler'),
            //Horizantal list view starts here
          ),
          HorizantalList(),
          //Padding widget
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text('Yeni Gelen Ürünler'),
          ),
          //Grid View

          Flexible(child: Products()),
        ],
      ),
    );
  }
}
