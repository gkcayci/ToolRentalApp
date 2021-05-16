import 'package:avadanlik/db/users.dart';
import 'package:avadanlik/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:avadanlik/commons/common.dart';
import 'package:avadanlik/db/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPassworController = TextEditingController();
  String gender;
  String groupvalue = "erkek";
  bool hidePass = true;
  bool loading = false;
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          child: Stack(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/logo.png',
                                  width: 190.0,
                                  // height: 240.0,
                                )),
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
                                    controller: _nameTextController,
                                    decoration: InputDecoration(
                                        hintText: "İsim",
                                        icon: Icon(Icons.person_outline),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "İsim alanı boş olamaz !";
                                      }
                                      return null;
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
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          //   child: Container(
                          //     child: Row(
                          //       children: <Widget>[
                          //         Expanded(
                          //           child: ListTile(
                          //             title: Text(
                          //               "erkek",
                          //               textAlign: TextAlign.end,
                          //               style: TextStyle(color: Colors.black),
                          //             ),
                          //             trailing: Radio(
                          //               value: "erkek",
                          //               groupValue: groupvalue,
                          //               onChanged: (e) => valueChanged(e),
                          //             ),
                          //           ),
                          //         ),
                          //         Expanded(
                          //           child: ListTile(
                          //             title: Text(
                          //               "kadın",
                          //               textAlign: TextAlign.end,
                          //               style: TextStyle(color: Colors.black),
                          //             ),
                          //             trailing: Radio(
                          //               value: "kadın",
                          //               groupValue: groupvalue,
                          //               onChanged: (e) => valueChanged(e),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _confirmPassworController,
                                    obscureText: hidePass,
                                    decoration: InputDecoration(
                                        hintText: "Parolayı onayla",
                                        icon: Icon(Icons.lock_outline),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Şifre alanı boş olamaz !";
                                      } else if (value.length < 6) {
                                        return "Şifre en az 6 karakter uzunluğunda olmalıdır !";
                                      } else if (_passwordTextController.text !=
                                          value) {
                                        return "Şifreler eşleşmiyor !";
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
                                onPressed: () {
                                  validateForm();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Kaydol",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Zaten üye misiniz?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: deepOrange,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(16.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Divider(),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text(
                          //           "Google ile Kaydol",
                          //           style: TextStyle(
                          //               fontSize: 20, color: Colors.grey),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Divider(
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Text(
                                  "Google ile kaydol",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
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
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    child: MaterialButton(
                                        onPressed: () async {
                                          User user = await auth.googleSignIn();
                                          if (user != null) {
                                            _userServices.createUser({
                                              "name": user.displayName,
                                              "photo": user.photoURL,
                                              "email": user.email,
                                              "userId": user.uid,
                                            });
                                            changeScreenReplacement(
                                                context, HomePage());
                                          }
                                        },
                                        child: Image.asset(
                                          "images/google2.png",
                                          width: 40,
                                        ))),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: loading ?? true,
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.white.withOpacity(0.9),
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "erkek") {
        groupvalue = e;
        gender = e;
      } else if (e == "kadın") {
        groupvalue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      formState.reset();
      final User user = firebaseAuth.currentUser;
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser({
                    "username": _nameTextController.text,
                    "email": _emailTextController.text,
                    "userId": user.user.uid,
                  })
                })
            .catchError((err) => {print(err.toString())});

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
