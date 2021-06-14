import 'package:avadanlik/commons/common.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[600],
          title: Text("Avadanlık Kiralama Kuralları"),
          centerTitle: true,
        ),
        //  decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.yellow,
        //         Colors.deepOrange,
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: deepOrange, width: 2),
              ),
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/logo.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 400,
                      ),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
                        title: Text(
                          'Avadanlık Kiralama Kuralları',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Text(
                            '🧑‍🔧Sipariş verdikten sonra kiraladıklarım bölümünden sipariş tarihinizi kontrol etmenizi rica ederiz.\n🧑‍🔧Alet kiralama fiyatları günübirlik süreyi kapsar ve sipariş tarihinizden itibaren geçerlidir. \n🧑‍🔧Sipariş verdiğiniz tarihten itibaren ürün sizin için rezerve edilir ve günübirlik fiyatlandırma bu tarihten itibaren başlar.\n🧑‍🔧Sipariş verdiğiniz tarihten itibaren günübirlik süreyi doldurduktan sonra yine kiralamak isterseniz tekrardan ürünü rezerve etmeniz gerekecektir.\n🧑‍🔧Ürünlerimizi sağlam teslim etmek kullanıcının yükümündedir.\n🧑‍🔧Aksi taktirde ürün fiyatı kendisinden talep edilir.',
                            style: TextStyle(fontSize: 18, height: 1.4),
                          ),
                        ],
                      ),
                    ],
                  )),
            )));
  }
}
