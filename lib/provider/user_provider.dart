import 'package:avadanlik/db/order.dart';
import 'package:avadanlik/db/users.dart';
import 'package:avadanlik/models/cart_item.dart';
import 'package:avadanlik/models/order.dart';
import 'package:avadanlik/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:avadanlik/models/product.dart';
import 'package:uuid/uuid.dart';

import 'dart:async';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  //getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print("CREATE USER");
        _firestore
            .collection('users')
            .doc(user.user.uid)
            .set({'name': name, 'email': email, 'uid': user.user.uid});
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      //print("CART ITEMS: ${userModel.cart.length}");
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart({ProductModel product}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.picture,
        "productId": product.id,
        "rent": product.rent,
        "sale": product.sale,
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("Sepetteki Ürün: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("HATA ${e.toString()}");
      return false;
    }
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("Ürün: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("HATA ${e.toString()}");
      return false;
    }
  }

  getOrders() async {
    var orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }
}

// import 'package:avadanlik/db/users.dart';
// import 'package:avadanlik/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

// class UserProvider with ChangeNotifier {
//   FirebaseAuth _auth;
//   User _user;
//   Status _status = Status.Uninitialized;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   UserServices _userServices = UserServices();
//   UserModel _userModel;

// // getter
//   UserModel get userModel => _userModel;
//   Status get status => _status;
//   User get user => _user;

//   UserProvider.initialize() : _auth = FirebaseAuth.instance {
//     _auth.authStateChanges().listen(_onStateChanged);
//   }
//   Future<bool> signIn(String email, String password) async {
//     try {
//       _status = Status.Authenticated;
//       notifyListeners();
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<bool> signUp(String name, String email, String password) async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((user) {
//         _firestore
//             .collection('users')
//             .doc(user.user.uid)
//             .set({'name': name, 'email': email, 'uid': user.user.uid});
//       });
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future signOut() async {
//     _auth.signOut();
//     _status = Status.Unauthenticated;
//     notifyListeners();
//     return Future.delayed(Duration.zero);
//   }

//   Future<void> _onStateChanged(User user) async {
//     if (user == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _user = user;
//       _userModel = await _userServices.getUserbyId(user.uid);
//       _status = Status.Authenticated;
//     }
//     notifyListeners();
//   }
// }
