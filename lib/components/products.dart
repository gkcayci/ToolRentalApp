import 'package:flutter/material.dart';
import 'package:avadanlik/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productlist = [
    {
      "name": "Çim Biçme Makinesi",
      "picture": "images/products/Alpina Benzinli Çim Biçme Makinesi.jpg",
      "sale_price": 5319,
      "rent_price": 53.19,
      "brand": "Albina",
      "detail": " Albina Benzinli Çim Biçme Makinesi" +
          "ürünü sayesinde bahçenizdeki istemediğiniz" +
          "bitki ve çimleri biçmek için idealdir." +
          "\n"
              " Teknik Özellikler :" +
          "\n"
              "- Modeli	Benzinli Çim Biçme Makinesi" +
          "\n"
              "- Silindir Hacmi	160 cc" +
          "\n"
              "- Kesme Genişliği	51 cm	" +
          "\n"
              "- Kesme Yüksekliği	25-90 mm",
      "category": "Çim Biçme Makineleri",
    },
    {
      "name": "Takım Çantası",
      "picture": "images/products/Teknisyen Takım Çantası.jpg",
      "sale_price": 239.99,
      "rent_price": 2.39,
      "brand": "Super-Bag",
      "detail":
          "Teknisyen Takım Çantası, teknik ve hobby amaçlı kullanıma uygun sağlam ve dayanıklı bir üründür."
                  "\n"
                  " Teknik Özellikler :" +
              "\n"
                  "- Malzeme	Sağlam dayanımı yüksek copolimer hammadde	" +
              "\n"
                  "- Yükseklik	18 cm	" +
              "\n"
                  "- Genişlik	48 cm	" +
              "\n"
                  "- Derinlik	39,8 cm",
      "category": "Takım Çantaları",
    },
    {
      "name": "Matkap",
      "picture": "images/products/Bosch Darbeli Akülü Matkap GSB 18 Volt.jpg",
      "sale_price": 499.90,
      "rent_price": 4.99,
      "brand": "Bosch Darbeli Akülü",
      "detail":
          "Bosch Darbeli Akülü Matkap GSB 18 Volt , tadilat işlerinizde yardımcınız."
                  "\n"
                  " Teknik Özellikler :" +
              "\n"
                  "- Modeli	Darbeli Matkap" +
              "\n"
                  "- Güç	18 Volt	" +
              "\n"
                  "- Tork	50 Nm	" +
              "\n"
                  "- Delme Kapasitesi Metal	13 mm",
      "category": "Matkaplar",
    },
    {
      "name": "Taşlama Makinesi",
      "picture": "images/products/Dewalt Taşlama Makinesi DWE4056.jpg",
      "sale_price": 599.90,
      "rent_price": 5.99,
      "brand": "Dewalt",
      "detail": "Kesme, taşlama ve zımparamala gibi işlemleri" +
          "hızlı ve güvenli bir şekilde yapmanıza imkan sunan" +
          "taşlama makineleri arasından seçebileceğiniz" +
          " Dewalt Taşlama Makinesi DWE4056 800 watt güce sahiptir ve 1,6 kg ağırlığa sahiptir." +
          "\n"
              " Teknik Özellikler :" +
          "\n"
              "- Güç	800 Watt" +
          "\n"
              "- Yüksüz Hızı	0-11000 dev/dk" +
          "\n"
              "- Disk Boyutu	115 mm" +
          "\n"
              "- Mil Çapı	M14",
      "category": "Taşlamalar",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productlist.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Singleprod(
              prodname: productlist[index]['name'],
              prodpicture: productlist[index]['picture'],
              prodsaleprice: productlist[index]['sale_price'],
              prodrentprice: productlist[index]['rent_price'],
              prodbrand: productlist[index]['brand'],
              proddetail: productlist[index]['detail'],
              prodcategory: productlist[index]['category'],
            ),
          );
        });
  }
}

class Singleprod extends StatelessWidget {
  final prodname;
  final prodpicture;
  final prodsaleprice;
  final prodrentprice;
  final prodbrand;
  final proddetail;
  final prodcategory;

  Singleprod({
    this.prodname,
    this.prodpicture,
    this.prodsaleprice,
    this.prodrentprice,
    this.prodbrand,
    this.proddetail,
    this.prodcategory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prodname,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //here we are passing the values of the product to the product details page
                  builder: (context) => new ProductDetails(
                        productDetailName: prodname,
                        productDetailPicture: prodpicture,
                        productDetailSalePrice: prodsaleprice,
                        productDetailRentPrice: prodrentprice,
                        productDetailBrand: prodbrand,
                        productDetaildetail: proddetail,
                        productDetailCategory: prodcategory,
                      ))),
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(prodname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                          ),
                          new Text(
                            "\₺${prodrentprice}",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )
                        ],
                      )),
                  child: Image.asset(
                    prodpicture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
