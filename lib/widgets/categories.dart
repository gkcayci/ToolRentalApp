import 'package:avadanlik/commons/loading.dart';
import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

import '../models/category.dart';
import 'custom_text.dart';

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
                      child: Loading(),
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
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.deepOrange.withOpacity(0),
                    Colors.deepOrange.withOpacity(0),
                    Colors.deepOrange.withOpacity(0),
                    Colors.deepOrange.withOpacity(0),
                    Colors.deepOrange.withOpacity(0),
                    Colors.deepOrange.withOpacity(0.0),
                    Colors.deepOrange.withOpacity(0.0),
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
                      weight: FontWeight.w300)))
        ],
      ),
    );
  }
}
