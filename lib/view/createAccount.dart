import 'package:fits_daxno/Constants/Theme.dart';
import 'package:fits_daxno/Constants/constants.dart';
import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:fits_daxno/controller/firebase_controller.dart';
import 'package:fits_daxno/view/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_auth/email_auth.dart';

import '../Widgets/ProgressPopUp.dart';
import '../Widgets/toast.dart';
import '../controller/firebaseAuth_controller.dart';
class createAccountView extends StatefulWidget {
  const createAccountView({Key ,key}) : super(key: key);

  @override
  _createAccountViewState createState() => _createAccountViewState();
}

class _createAccountViewState extends State<createAccountView> {
  var obscure=false;
  ScrollController _controller=new ScrollController();

  firebaseAuthController auth = new firebaseAuthController();

  firebaseController firestoreController = new firebaseController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController phone = new TextEditingController();
  TextEditingController age = new TextEditingController();


  TextEditingController username = new TextEditingController();

  TextEditingController gender = new TextEditingController();

  TextEditingController confirmpassword = new TextEditingController();

  TextEditingController otpcontroller = new TextEditingController();

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  EmailAuth emailAuth=new EmailAuth(
    sessionName: "Sample session 2",
  );


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: sh,
          width: sw,
          decoration: BoxDecoration(
              color: appColor,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/background.png')
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                      GestureDetector(child: Icon(Icons.arrow_back_ios,color: Colors.white,),onTap: (){Navigator.of(context).pop();},)
                      ],
                    ),
                    SizedBox(height: sh*0.08,),
                    Container(
                      height: 150,
                      width: sw,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png')
                          )
                      ),
                    ),
                    Text('Create Account',style: GoogleFonts.workSans(textStyle: TextStyle(color:appTextColor,fontSize:20)),),
                    SizedBox(height: 10,),
                    CustomTextFields(hintText:'User Name',prefixIcon:Icon(CupertinoIcons.person_circle,color: Colors.black,),controller: username,),
                    Row(
                      children: [
                        Expanded(child: CustomTextFields(hintText:'Age',prefixIcon:Icon(CupertinoIcons.person_3_fill,color: Colors.black,),controller: age,),
                        ),
                        SizedBox(width: 8,),
                        Expanded(child: CustomTextFields(controller: gender,hintText:'Gender',prefixIcon:Icon(CupertinoIcons.person_circle,color: Colors.black,),),
                        ),
                      ],
                    ),
                    CustomTextFields(controller: email,hintText:'Email',prefixIcon:Icon(CupertinoIcons.mail_solid,color: Colors.black,size: 20,),),
                    CustomTextFields(controller: phone,hintText:'Phone',prefixIcon:Icon(CupertinoIcons.phone_fill,color: Colors.black,),),
                    CustomTextFields(        validator:
                            (String? value) {
                          if (value!.isEmpty) {

                            return "Please fill out this feild";
                          }else if (value.length<6) {
                            return "Password length must be greater than 6";
                          }
                          return null;
                        },controller:password,hintText:'Password',prefixIcon:Icon(CupertinoIcons.lock_fill,color: Colors.black,),),
                    CustomTextFields(   validator:
                        (String? value) {
                      if (value!.isEmpty) {

                        return "Please fill out this feild";
                      }else if (value.length<6) {
                        return "Password length must be greater than 6";
                      }
                      return null;
                    },controller: confirmpassword,hintText:'Confirm password',prefixIcon:Icon(CupertinoIcons.lock_fill,color: Colors.black,),),
                    SizedBox(height: 20,),
                    CustomButton(text: 'Create Account', onPressed: ()async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                    if(password.text!=confirmpassword.text){
                      toastempty(
                          context,
                          'Password doen\'t match',
                          Colors.red);
                    }
                    if (validateForm() && confirmpassword.text==password.text) {
                      ProgressPopup(context);
                      try {
                        auth
                            .signUpWithEmailAndPassword(
                            email.text, password.text)
                            .then((value) => {
                          Navigator.pop(context),
                          if (value)
                            {
                              saveData(),
                              auth
                                  .signInWithEmailAndPassword(
                                  email.text,
                                  password.text)
                                  .then((value) => {
                                Navigator.pop(
                                    context),
                                if (value)
                                  {
                                    pref.setBool(
                                        'logined',
                                        true),
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => bottomBar()),
                                            (route) => false)
                                  }
                                else
                                  {}
                              })
                            }
                          else
                            {
                              Navigator.pop(context),
                              toastempty(
                                  context,
                                  'email already registered',
                                  Colors.red),
                            }
                        });
                      } catch (ex) {
                        Navigator.pop(context);
                        toastempty(
                            context,
                            'email already registered',
                            Colors.red);
                      }
                    }}),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 10,width: 10,
                            padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black,width: 0)),
                            ),
                        Text(" By creating an account or signing you agree to ",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontSize: 12)),),
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("our ",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontSize: 12)),),
                        Text("Terms and Conditions ",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontSize: 14,fontStyle: FontStyle.italic,fontWeight: FontWeight.w200)),),

                      ],
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
  saveData() async {
    var auth=await FirebaseAuth.instance;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('users');
    var temp = await collectionReference.doc(auth.currentUser!.uid).set({
      'email': email.text,
      'password': password.text,
      'phone': phone.text,
      'username': username.text,
      'age': age.text,
      'gender':gender.text,
      'image':'https://firebasestorage.googleapis.com/v0/b/fits-acae5.appspot.com/o/products%2Fman%202.png?alt=media&token=9972d114-ad5b-4a85-bba1-ab31303e27c2',
      'token':0,
    });
  }
}
