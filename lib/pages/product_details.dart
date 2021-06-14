import 'package:avadanlik/commons/common.dart';
import 'package:avadanlik/commons/loading.dart';
import 'package:avadanlik/models/product.dart';
import 'package:avadanlik/pages/cart.dart';
import 'package:avadanlik/provider/app_provider.dart';
//import 'package:avadanlik/provider/product.dart';
import 'package:avadanlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({Key key, this.product}) : super(key: key);

  // final productDetailName;
  // final productDetailPicture;
  // final productDetailRentPrice;
  // final productDetailSalePrice;
  // final productDetailBrand;
  // final productDetaildetail;
  // final productDetailCategory;
  // ProductDetails({
  //   this.productDetailName,
  //   this.productDetailPicture,
  //   this.productDetailRentPrice,
  //   this.productDetailSalePrice,
  //   this.productDetailBrand,
  //   this.productDetaildetail,
  //   this.productDetailCategory,
  // });
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  // String _color = "";
  // String _size = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _color = widget.product.colors[0];
    // _size = widget.product.sizes[0];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    // final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Loading(),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.product.picture,
                    fit: BoxFit.fill,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.product.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '\₺${widget.product.rent}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.deepOrange,
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print("CLICKED");
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35))),
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   child: CustomText(
                          //     text: "Select a Color",
                          //     color: white,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   child: DropdownButton<String>(
                          //       value: _color,
                          //       style: TextStyle(color: white),
                          //       items: widget.product.colors
                          //           .map<DropdownMenuItem<String>>(
                          //               (value) => DropdownMenuItem(
                          //                   value: value,
                          //                   child: CustomText(
                          //                     text: value,
                          //                     color: Colors.red,
                          //                   )))
                          //           .toList(),
                          //       onChanged: (value) {
                          //         setState(() {
                          //           _color = value;
                          //         });
                          //       }),
                          // )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(0),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: CustomText(
                    //           text: "Select a Size",
                    //           color: white,
                    //         ),
                    //       ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: DropdownButton<String>(
                    //       value: _size,
                    //       style: TextStyle(color: white),
                    //       items: widget.product.sizes
                    //           .map<DropdownMenuItem<String>>(
                    //               (value) => DropdownMenuItem(
                    //                   value: value,
                    //                   child: CustomText(
                    //                     text: value,
                    //                     color: Colors.red,
                    //                   )))
                    //           .toList(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _size = value;
                    //         });
                    //       }),
                    // )
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${widget.product.description}",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${widget.product.technicalSpecifications}",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              appProvider.changeIsLoading();
                              bool success = await userProvider.addToCart(
                                product: widget.product,
                              );
                              if (success) {
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Text("Sepete eklendi.")));
                                userProvider.reloadUserModel();
                                appProvider.changeIsLoading();
                                return;
                              } else {
                                _key.currentState.showSnackBar(SnackBar(
                                    content: Text("Sepete eklenemedi.")));
                                appProvider.changeIsLoading();
                                return;
                              }
                              // appProvider.changeIsLoading();
                              // bool success = await userProvider.addToCart(
                              //     product: widget.product,
                              //     color: _color,
                              //     size: _size);
                              // if (success) {
                              //   _key.currentState.showSnackBar(
                              //       SnackBar(content: Text("Added to Cart!")));
                              //   userProvider.reloadUserModel();
                              //   appProvider.changeIsLoading();
                              //   return;
                              // } else {
                              //   _key.currentState.showSnackBar(SnackBar(
                              //       content: Text("Not added to Cart!")));
                              //   appProvider.changeIsLoading();
                              //   return;
                              // }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: appProvider.isLoading
                                ? Loading()
                                : Text(
                                    "Sepete Ekle",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

// class _ProductDetailsState extends State<ProductDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: new AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepOrange, Colors.yellow],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//           ),
//         ),
//         title: InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => new HomePage()));
//             },
//             child: Text('Avadanlık')),
//         actions: <Widget>[
//           new IconButton(
//               icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
//         ],
//       ),
//       body: new ListView(
//         children: <Widget>[
//           new Container(
//             height: 300.0,
//             child: GridTile(
//               child: Container(
//                 color: Colors.white,
//                 child: Image.asset(widget.productDetailPicture),
//               ),
//               footer: new Container(
//                 color: Colors.white70,
//                 child: ListTile(
//                   leading: new Text(
//                     widget.productDetailName,
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                   ),
//                   title: new Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: new Text(
//                           "Liste Fiyatı:" +
//                               ""
//                                   " \₺${widget.productDetailSalePrice}",
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ),
//                       Expanded(
//                         child: new Text(
//                           "Günlük Kira: " +
//                               "\₺${widget.productDetailRentPrice}",
//                           style: TextStyle(color: Colors.orange),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // the second buttons
//           Row(
//             children: <Widget>[
//               // the rent button
//               Expanded(
//                 child: MaterialButton(
//                     onPressed: () {},
//                     color: Colors.orange[900],
//                     textColor: Colors.white,
//                     child: new Text("Kirala")),
//               ),

//               new IconButton(
//                   icon: Icon(Icons.add_shopping_cart, color: Colors.orange),
//                   onPressed: () {}),
//               new IconButton(
//                   icon: Icon(Icons.favorite_border, color: Colors.orange),
//                   onPressed: () {}),
//             ],
//           ),
//           Divider(color: Colors.black),
//           new ListTile(
//             title: new Text("Ürün Detayları"),
//             subtitle: new Text(widget.productDetaildetail),
//           ),

//           Divider(),
//           new Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
//                 child: new Text(
//                   "Ürün Kategorisi:",
//                   style: TextStyle(color: Colors.grey[700]),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: new Text(widget.productDetailCategory),
//               ),
//             ],
//           ),
//           new Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
//                 child: new Text(
//                   "Marka:",
//                   style: TextStyle(color: Colors.grey[700]),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: new Text(widget.productDetailBrand),
//               ),
//             ],
//           ),
//           new Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
//                 child: new Text(
//                   "Ürün Durumu:",
//                   style: TextStyle(color: Colors.grey[700]),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: new Text("Yeni"),
//               ),
//             ],
//           ),
//           // Similar products section

//           Divider(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: new Text("Benzer Ürünler"),
//           ),
//           Container(
//             height: 340.0,
//             child: SimilarProducts(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SimilarProducts extends StatefulWidget {
//   @override
//   _SimilarProductsState createState() => _SimilarProductsState();
// }

// class _SimilarProductsState extends State<SimilarProducts> {
//   var productlist = [
//     {
//       "name": "Çim Biçme Makinesi",
//       "picture": "images/products/Alpina Benzinli Çim Biçme Makinesi.jpg",
//       "sale_price": 5319,
//       "rent_price": 53.19,
//       "brand": "Albina",
//       "detail": " Albina Benzinli Çim Biçme Makinesi" +
//           "ürünü sayesinde bahçenizdeki istemediğiniz" +
//           "bitki ve çimleri biçmek için idealdir." +
//           "\n"
//               " Teknik Özellikler :" +
//           "\n"
//               "- Modeli	Benzinli Çim Biçme Makinesi" +
//           "\n"
//               "- Silindir Hacmi	160 cc" +
//           "\n"
//               "- Kesme Genişliği	51 cm	" +
//           "\n"
//               "- Kesme Yüksekliği	25-90 mm",
//       "category": "Çim Biçme Makineleri",
//     },
//     {
//       "name": "Takım Çantası",
//       "picture": "images/products/Teknisyen Takım Çantası.jpg",
//       "sale_price": 239.99,
//       "rent_price": 2.39,
//       "brand": "Super-Bag",
//       "detail":
//           "Teknisyen Takım Çantası, teknik ve hobby amaçlı kullanıma uygun sağlam ve dayanıklı bir üründür."
//                   "\n"
//                   " Teknik Özellikler :" +
//               "\n"
//                   "- Malzeme	Sağlam dayanımı yüksek copolimer hammadde	" +
//               "\n"
//                   "- Yükseklik	18 cm	" +
//               "\n"
//                   "- Genişlik	48 cm	" +
//               "\n"
//                   "- Derinlik	39,8 cm",
//       "category": "Takım Çantaları",
//     },
//     {
//       "name": "Matkap",
//       "picture": "images/products/Bosch Darbeli Akülü Matkap GSB 18 Volt.jpg",
//       "sale_price": 499.90,
//       "rent_price": 4.99,
//       "brand": "Bosch Darbeli Akülü",
//       "detail":
//           "Bosch Darbeli Akülü Matkap GSB 18 Volt , tadilat işlerinizde yardımcınız."
//                   "\n"
//                   " Teknik Özellikler :" +
//               "\n"
//                   "- Modeli	Darbeli Matkap" +
//               "\n"
//                   "- Güç	18 Volt	" +
//               "\n"
//                   "- Tork	50 Nm	" +
//               "\n"
//                   "- Delme Kapasitesi Metal	13 mm",
//       "category": "Matkaplar",
//     },
//     {
//       "name": "Taşlama Makinesi",
//       "picture": "images/products/Dewalt Taşlama Makinesi DWE4056.jpg",
//       "sale_price": 599.90,
//       "rent_price": 5.99,
//       "brand": "Dewalt",
//       "detail": "Kesme, taşlama ve zımparamala gibi işlemleri" +
//           "hızlı ve güvenli bir şekilde yapmanıza imkan sunan" +
//           "taşlama makineleri arasından seçebileceğiniz" +
//           " Dewalt Taşlama Makinesi DWE4056 800 watt güce sahiptir ve 1,6 kg ağırlığa sahiptir." +
//           "\n"
//               " Teknik Özellikler :" +
//           "\n"
//               "- Güç	800 Watt" +
//           "\n"
//               "- Yüksüz Hızı	0-11000 dev/dk" +
//           "\n"
//               "- Disk Boyutu	115 mm" +
//           "\n"
//               "- Mil Çapı	M14",
//       "category": "Taşlamalar",
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         itemCount: productlist.length,
//         gridDelegate:
//             new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (BuildContext context, int index) {
//           return SimilarSingleProd(
//             prodname: productlist[index]['name'],
//             prodpicture: productlist[index]['picture'],
//             prodsaleprice: productlist[index]['sale_price'],
//             prodrentprice: productlist[index]['rent_price'],
//             prodbrand: productlist[index]['brand'],
//             proddetail: productlist[index]['detail'],
//             prodcategory: productlist[index]['category'],
//           );
//         });
//   }
// }

// class SimilarSingleProd extends StatelessWidget {
//   final prodname;
//   final prodpicture;
//   final prodsaleprice;
//   final prodrentprice;
//   final prodbrand;
//   final proddetail;
//   final prodcategory;

//   SimilarSingleProd({
//     this.prodname,
//     this.prodpicture,
//     this.prodsaleprice,
//     this.prodrentprice,
//     this.prodbrand,
//     this.proddetail,
//     this.prodcategory,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Hero(
//           tag: prodname,
//           child: Material(
//             child: InkWell(
//               onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//                   //here we are passing the values of the product to the product details page
//                   builder: (context) => new ProductDetails(
//                         productDetailName: prodname,
//                         productDetailPicture: prodpicture,
//                         productDetailSalePrice: prodsaleprice,
//                         productDetailRentPrice: prodrentprice,
//                         productDetailBrand: prodbrand,
//                         productDetaildetail: proddetail,
//                         productDetailCategory: prodcategory,
//                       ))),
//               child: GridTile(
//                   footer: Container(
//                       color: Colors.white70,
//                       child: new Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Text(prodname,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16.0)),
//                           ),
//                           new Text(
//                             "\₺${prodrentprice}",
//                             style: TextStyle(
//                                 color: Colors.orange,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16.0),
//                           )
//                         ],
//                       )),
//                   child: Image.asset(
//                     prodpicture,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//           )),
//     );
//   }
// }
