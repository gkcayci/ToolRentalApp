import 'package:avadanlik/components/HorizantalListView.dart';
import 'package:avadanlik/components/products.dart';
import 'package:avadanlik/pages/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:avadanlik/commons/common.dart';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: deepOrange),
        elevation: 0.1,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: TextFormField(
            controller: _searchController,
            decoration:
                InputDecoration(hintText: "Arama...", border: InputBorder.none),
            validator: (value) {
              if (value.isEmpty) {
                return "Lütfen arama alanını doldurun!";
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: deepOrange), onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: deepOrange),
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
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.yellow],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Ana Sayfa'),
                    leading: Icon(Icons.home, color: grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Hesabım'),
                    leading: Icon(Icons.person, color: grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Kiraladıklarım'),
                    leading: Icon(Icons.shopping_basket, color: grey))),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart()));
                },
                child: ListTile(
                    title: Text('Sepetim'),
                    leading: Icon(Icons.shopping_cart, color: grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Beğendiklerim'),
                    leading: Icon(Icons.favorite, color: grey))),
            Divider(color: Colors.black),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Ayarlar'),
                    leading: Icon(Icons.settings, color: grey))),
            InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Hakkımızda'),
                    leading: Icon(Icons.help, color: Colors.grey))),
            Divider(),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: ListTile(
                title: Text('Çıkış'),
                leading: Icon(
                  Icons.transit_enterexit,
                  color: grey,
                ),
              ),
            ),
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
