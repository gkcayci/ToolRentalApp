import 'package:avadanlik/models/cart_item.dart';
import 'package:avadanlik/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'users';
  void createUser(Map<String, dynamic> data) async {
    await _firestore
        .collection(collection)
        .doc(data["uid"])
        .set(data)
        .then((value) => print("Kullanıcı eklendi"))
        .catchError((error) => print("Kullanıcı eklenemedi: $error"));
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  void addToCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
