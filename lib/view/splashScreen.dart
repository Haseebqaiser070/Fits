
import 'dart:async';
import 'package:fits_daxno/Constants/Theme.dart';
import 'package:fits_daxno/view/accountView.dart';
import 'package:fits_daxno/view/conditionsView.dart';
import 'package:fits_daxno/view/contactUs.dart';
import 'package:fits_daxno/view/conversationsView.dart';
import 'package:fits_daxno/view/tokenView.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../main.dart';
import 'bottomNavigationBar.dart';
import 'loginView.dart';

class splashView extends StatefulWidget {
  const splashView({Key,key}) : super(key: key);

  @override
  State<splashView> createState() => _splashViewState();
}

class _splashViewState extends State<splashView> {
  @override
  void initState() {
    _NextRoute();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sh=MediaQuery.of(context).size.height;
    sw=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit:BoxFit.fill,
              image: AssetImage("assets/images/background.png")),
        ),
        child: Center(
          child: Container(
              child: Image.asset("assets/images/logo.png")),
        ),
      ),
    );
  }
  _NextRoute(){
    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>bottomBar()),
          // isFirstTime! ? const OnBoarding1() : const Login(),
        );
      },
    );
  }
}
