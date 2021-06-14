//custom imports
import 'package:avadanlik/commons/common.dart';
//import 'package:avadanlik/components/HorizantalListView.dart';
import 'package:avadanlik/db/products.dart';
import 'package:avadanlik/models/category.dart';
import 'package:avadanlik/pages/cart.dart';
import 'package:avadanlik/pages/category.dart';
import 'package:avadanlik/pages/info.dart';
import 'package:avadanlik/pages/login.dart';
import 'package:avadanlik/pages/order.dart';
import 'package:avadanlik/pages/product_search.dart';
import 'package:avadanlik/provider/app_provider.dart';
import 'package:avadanlik/provider/category.dart';
import 'package:avadanlik/provider/product.dart';
import 'package:avadanlik/provider/user_provider.dart';
//import 'package:avadanlik/widgets/categories.dart';
import 'package:avadanlik/widgets/custom_text.dart';
import 'package:avadanlik/widgets/product_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // AppProvider appProvider = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    ProductServices _productServices = ProductServices();
    final appProvider = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final _key = GlobalKey<ScaffoldState>();
    Widget image_carousel = new Container(
      height: 181.0,
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
        iconTheme: IconThemeData(color: deepOrange),
        elevation: 0.1,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: Container(
            child: ListTile(
              title: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (pattern) async {
                  await productProvider.search(productName: pattern);
                  changeScreen(context, ProductSearchScreen());
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  hintText: 'Arama... ',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          // new IconButton(
          //     icon: Icon(Icons.search, color: deepOrange), onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: deepOrange),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new CartScreen()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.yellow],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "name loading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "mail loading...",
                color: white,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new HomePage()));
                },
                child: ListTile(
                    title: Text('Ana Sayfa'),
                    leading: Icon(Icons.home, color: Colors.grey))),
            // InkWell(
            //     onTap: () {
            //       _key.currentState.showSnackBar(
            //           SnackBar(content: Text("Kullanıcı Profili")));
            //     },
            //     child: ListTile(
            //         title: Text('Hesabım'),
            //         leading: Icon(Icons.person, color: Colors.grey))),
            InkWell(
                onTap: () async {
                  await userProvider.getOrders();
                  changeScreen(context, OrdersScreen());
                },
                child: ListTile(
                    title: Text('Kiraladıklarım'),
                    leading: Icon(Icons.shopping_basket, color: Colors.grey))),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new CartScreen()));
                },
                child: ListTile(
                    title: Text('Sepetim'),
                    leading: Icon(Icons.shopping_cart, color: Colors.grey))),
            InkWell(
                onTap: () {
                  changeScreen(context, InfoPage());
                },
                child: ListTile(
                    title: Text('Bilgilendirme'),
                    leading: Icon(Icons.info, color: Colors.grey))),
            Divider(color: Colors.black),
            // InkWell(
            //     onTap: () {},
            //     child: ListTile(
            //         title: Text('Ayarlar'),
            //         leading: Icon(Icons.settings, color: Colors.grey))),
            InkWell(
              onTap: () {
                user.signOut();
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: ListTile(
                title: Text('Çıkış'),
                leading: Icon(
                  Icons.transit_enterexit,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          //image carousel starts here
          image_carousel,
          //Padding Widget
          new Padding(
            padding: const EdgeInsets.all(2.0),
            child: new Text(
              'Kategoriler',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.fill
                  ..strokeWidth = 1
                  ..color = Colors.black,
              ),
            ),
            //Horizantal list view starts here
          ),
          // HorizantalList(),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
//                              app.changeLoading();
                        await productProvider.loadProductsByCategory(
                            categoryName:
                                categoryProvider.categories[index].name);

                        changeScreen(
                            context,
                            CategoryScreen(
                              categoryModel: categoryProvider.categories[index],
                            ));

//                              app.changeLoading();
                      },
                      child: CategoryWidget(
                        category: categoryProvider.categories[index],
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //Padding widget
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              'Kiralık Aletler',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                foreground: Paint()
                  ..style = PaintingStyle.fill
                  ..strokeWidth = 1
                  ..color = Colors.black,
              ),
            ),
          ),
          // FeaturedProducts(),

          Column(
            children: productProvider.products
                .map((item) => GestureDetector(
                      child: ProductCard(
                        product: item,
                      ),
                    ))
                .toList(),
          )
          //  Flexible(child: Products()),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      // child: Loading(),
                    )),
                    Center(
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: category.image),
                    )
                  ],
                )),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )),
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: category.name,
                    color: Colors.white,
                    size: 26,
                    weight: FontWeight.w300,
                  )))
        ],
      ),
    );
  }
}
