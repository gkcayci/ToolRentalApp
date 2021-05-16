import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/homePage.dart';
import 'package:avadanlik/pages/signup.dart';
import 'package:avadanlik/commons/common.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  bool hidePass = true;

  @override
  void initState() {
    super.initState();
    //isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    // await googleSign.signOut();
    googleSignIn.disconnect();
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    final User user = firebaseAuth.currentUser;
    if (user != null) {
      setState(() => isLogedin = true);
    }

    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    if (credential != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: credential.providerId)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        //insert the user to our collection
        FirebaseFirestore.instance
            .collection("users")
            .doc(credential.providerId)
            .set({
          "id": credential.providerId,
          "password": credential.signInMethod,
        });
        await preferences.setString("id", credential.providerId);
        await preferences.setString("password", credential.signInMethod);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['password']);
      }
      Fluttertoast.showToast(msg: "Giriş başarılı!");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Giriş Başarısız!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'images/logo.png',
                    width: 250.0,
                    // height: 240.0,
                  )),
            ),
            // Image.asset(
            //   'images/back.jpeg',
            //   fit: BoxFit.fill,
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            // Container(
            //   color: Colors.black.withOpacity(0.4),
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Lütfen e-posta adresinizin geçerli olduğundan emin olun';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _passwordTextController,
                                obscureText: hidePass,
                                decoration: InputDecoration(
                                    hintText: "Parola",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Şifre alanı boş olamaz !";
                                  } else if (value.length < 6) {
                                    return "Şifre en az 6 karakter uzunluğunda olmalıdır !";
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: deepOrange,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Giriş",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Şifremi unuttum",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    "Hesap oluştur",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ))),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Divider(),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Veya",
                            //     style:
                            //         TextStyle(fontSize: 20, color: Colors.grey),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Divider(
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Text(
                              "Google ile giriş",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.deepOrange,
                              size: 30.0,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                                child: MaterialButton(
                                    onPressed: () {
                                      handleSignIn();
                                    },
                                    child: Image.asset(
                                      "images/google2.png",
                                      width: 45,
                                    ))),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(20.0),
                      //     color: Colors.deepOrange.withOpacity(0.8),
                      //     elevation: 0.0,
                      //     child: MaterialButton(
                      //       onPressed: () {
                      //         handleSignIn();
                      //       },
                      //       minWidth: MediaQuery.of(context).size.width,
                      //       child: Row(
                      //         children: <Widget>[
                      //           Padding(
                      //             padding: const EdgeInsets.all(4.0),
                      //             child: Image.asset(
                      //               "images/google.png",
                      //               width: 30.0,
                      //               height: 30.0,
                      //             ),
                      //           ),
                      //           Text(
                      //             "Google",
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 22.0),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
