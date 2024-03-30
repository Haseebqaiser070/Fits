import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fits_daxno/controller/loginController.dart';
import 'package:fits_daxno/view/Home.dart';
import 'package:fits_daxno/view/bottomNavigationBar.dart';
import 'package:fits_daxno/view/createAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';
import '../Widgets/CustomButton.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/ProgressPopUp.dart';
import '../controller/firebaseAuth_controller.dart';
import '../controller/firebase_controller.dart';

class loginView extends StatefulWidget {
  const loginView({Key, key}) : super(key: key);

  @override
  _loginViewState createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  loginController controller = Get.put(loginController());
  var obscure = false;
  firebaseAuthController auth = new firebaseAuthController();

  firebaseController firestoreController = new firebaseController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key:formkey,
          child: Container(
            height: sh,
            width: sw,
            decoration: BoxDecoration(
                color: appColor,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/background.png'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: sh * 0.05,
                          ),
                          Container(
                            height: 150,
                            width: sw,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFields(
                            hintText: 'Email/Phone no',
                            prefixIcon: Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.black,
                            ),
                            controller: email,
                          ),
                          CustomTextFields(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              CupertinoIcons.lock_fill,
                              color: Colors.black,
                            ),
                            controller: password,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            createAccountView()));
                                  },
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  )),
                              Text(
                                "Forget Password",
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              text: 'Login',
                              onPressed: () async {
                                var pref = await SharedPreferences.getInstance();
                                if (validateForm()) {
                                  ProgressPopup(context);
                                  auth
                                      .signInWithEmailAndPassword(
                                          email.text, password.text)
                                      .then((value) => {
                                            Navigator.pop(context),
                                            if (value)
                                              {
                                                pref.setBool('logined', true),
                                                logined=true,
                                               Navigator.pop(context),
                                              }
                                            else
                                              {}
                                          });
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20),
                                  child: InkWell(
                                    onTap: () async {
                                      var pref =
                                          await SharedPreferences.getInstance();
                                      auth.GoogleSignOpt().then((value) => {
                                            print('yaha'),
                                            if (value)
                                              {
                                                saveData(),
                                                pref.setBool('logined', true),
                                                logined=true,
                                               Navigator.pop(context)
                                              }
                                            else
                                              {}
                                          });
                                    },
                                    child: Container(
                                      width: sw,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(sw),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                  'assets/images/Google.png'),
                                            ),
                                            Text(
                                              "Continue with Google",
                                              style: GoogleFonts.workSans(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    width: sw,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(sw),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Icon(
                                              FontAwesomeIcons.facebookSquare,
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                          Text(
                                            "Continue with Facebook",
                                            style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    final form = formkey.currentState;
    if (form!.validate()) {
      return true;
    }
    return false;
  }
  saveData( ) async {
    var auth = await FirebaseAuth.instance;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('users');
    var age = '';
    var phone = '';
    var password = '';
    var name = '';
    var gender = '';
    var image='';
    var token;
    try {
      var userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      name = userdata['username'];
      gender = userdata['gender'];
      age = userdata['age'];
      password = userdata['password'].toString();
      phone = userdata['phone'];
      image = userdata['image'];
      token = userdata['token'];
    } catch (ex) {}
    var temp = await collectionReference.doc(auth.currentUser!.uid).set({
      'email': auth.currentUser!.email,
      'password': password,
      'phone': phone,
      'username': name.isEmpty?auth.currentUser!.displayName:name,
      'age': age,
      'gender': gender,
      'token': token==0?0:token,
      'image': image.isEmpty?auth.currentUser!.photoURL:image,
    });
  }
}
