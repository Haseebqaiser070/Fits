import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';

class contactUsView extends StatefulWidget {
  const contactUsView({Key ,key}) : super(key: key);

  @override
  _contactUsViewState createState() => _contactUsViewState();
}

class _contactUsViewState extends State<contactUsView> {
  TextEditingController subject=new TextEditingController();
  TextEditingController detail=new TextEditingController();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: sw,
                color: appColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   SizedBox(width:40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Contact Us",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 18)),),
                        SizedBox(height: 20,),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),

              Container(
                height: sh*0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFields(hintText:'Subject',controller: subject,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical:5),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please fill out this feild";
                                }
                                return null;
                              },
                              controller: detail,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 1,
                              style:  GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                              decoration: InputDecoration(

                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Details',
                                border: InputBorder.none,
                                hintStyle:  GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        CustomButton(text: 'Submit', onPressed: ()async{
                          if(validateForm()){
                            final Email email = Email(
                              body: '${detail.text}',
                              subject: '${subject.text}',
                              recipients: ['saadk9062@gmail.com'],
                              isHTML: false,
                            );

                            await FlutterEmailSender.send(email).then((value)
                            {
                              FirebaseFirestore.instance.collection('contactSupport').add(
                                  {
                                    'subject':subject.text,
                                    'body': detail.text,
                                    'contact': FirebaseAuth.instance.currentUser!.email,
                                    'userId': FirebaseAuth.instance.currentUser!.uid
                                  });
                            });
                          }
                        })

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  bool validateForm() {
    final form = formkey.currentState;
    if (form!.validate()) {
      return true;
    }
    return false;
  }
}
