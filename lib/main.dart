import 'package:firebase_core/firebase_core.dart';
import 'package:fits_daxno/Constants/constants.dart';
import 'package:fits_daxno/view/accountView.dart';
import 'package:fits_daxno/view/addProductView.dart';
import 'package:fits_daxno/view/bottomNavigationBar.dart';
import 'package:fits_daxno/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    IsLogined();
    // TODO: implement initState
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
           primarySwatch: Colors.blue,
      ),
      home:splashView(),
    );
  }

  IsLogined()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    logined=pref.getBool('logined');
  }
}
