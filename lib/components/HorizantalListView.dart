import 'package:flutter/material.dart';

class HorizantalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imagecaption: 'Akülü Vidalama',
            imagelocation: 'images/categories/akülü vidalamalar.png',
          ),
          Category(
            imagecaption: 'Basınçlı Yıkama',
            imagelocation: 'images/categories/basınçlı yıkama makineleri.png',
          ),
          Category(
            imagecaption: 'Boya Tabancası ve Karıştırıcı',
            imagelocation:
                'images/categories/boya tabancası ve karıştırıcılar.png',
          ),
          Category(
            imagecaption: 'Çim Biçme Makineleri',
            imagelocation: 'images/categories/çim biçme makinesi.png',
          ),
          Category(
            imagecaption: 'İnşaat Makineleri',
            imagelocation: 'images/categories/inşaat makineleri.png',
          ),
          Category(
            imagecaption: 'Kaynak Makineleri',
            imagelocation: 'images/categories/kaynak makineleri.png',
          ),
          Category(
            imagecaption: 'Kırıcılar ve Deliciler',
            imagelocation: 'images/categories/kırıcılar ve deliciler.png',
          ),
          Category(
            imagecaption: 'Matkaplar',
            imagelocation: 'images/categories/matkaplar.png',
          ),
          Category(
            imagecaption: 'Mekanik El Aletleri',
            imagelocation: 'images/categories/mekanik el aletleri.png',
          ),
          Category(
            imagecaption: 'Merdiven',
            imagelocation: 'images/categories/merdivenler.png',
          ),
          Category(
            imagecaption: 'Ölçü Aletleri',
            imagelocation: 'images/categories/ölçü aletleri.png',
          ),
          Category(
            imagecaption: 'Takım Çantaları',
            imagelocation: 'images/categories/takım çantaları.png',
          ),
          Category(
            imagecaption: 'Taşlamalar',
            imagelocation: 'images/categories/taşlamalar.png',
          ),
          Category(
            imagecaption: 'Testereler',
            imagelocation: 'images/categories/testereler.png',
          ),
          Category(
            imagecaption: 'Zımpara ve Polisaj',
            imagelocation: 'images/categories/zımpara ve polisaj.png',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  //created these object so we can use their construct for each category of tool
  final String imagelocation;
  final String imagecaption;
  Category({this.imagecaption, this.imagelocation});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100,
          child: ListTile(
            title: Image.asset(
              imagelocation,
              width: 100,
              height: 80,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  imagecaption,
                )),
          ),
        ),
      ),
    );
  }
}
