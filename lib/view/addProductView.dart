
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:fits_daxno/view/loginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';
import '../Widgets/CustomTextFields.dart';

class addProductView extends StatefulWidget {
  const addProductView({Key, key}) : super(key: key);

  @override
  _addProductViewState createState() => _addProductViewState();
}

class _addProductViewState extends State<addProductView> {
  List items=['Used','New'];
  var selectedValue='New';
  TextEditingController title =new TextEditingController();
  TextEditingController price =new TextEditingController();
  TextEditingController address =new TextEditingController();
  TextEditingController model =new TextEditingController();
  bool box=true;
  bool reciept=true;
  bool legit=true;
  bool laces=true;
  List<PlatformFile> productImagesResults=[];
  List productImagesLinks=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 110,
              width: sw,
              color: appColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SizedBox(width:40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(

                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(fit:BoxFit.fill,image: AssetImage('assets/images/logo.png'))),),

                      Text("Add Product",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 18)),),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  CustomTextFields(hintText:'Product Title',controller: title),
                  CustomTextFields(hintText:'Price',controller: price,),
                  SizedBox(height: 10,),
                  DropdownButtonFormField(
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontSize: 14, color: Colors.black),
                    ) ,
                    decoration: InputDecoration(
                      hintText: 'Condition',
                      hintStyle:  GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 14, color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          )),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.black,
                    ),
                    hint: Text('Groups',
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 14, color: Colors.white),
                        )),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),

                    value: selectedValue,
                    onChanged: (value) {
                      selectedValue = value as String;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextFields(hintText:'Address',controller: address,),
                  CustomTextFields(hintText:'Model number',controller: model,),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    activeColor: appDarkColor,
                                    value: box, onChanged: (value){setState(() {
                                  box=value!;
                                });}),
                                Text(
                                  'Shoe Box',
                                  style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                               Checkbox(
                                   activeColor: appDarkColor,
                                   value: reciept, onChanged: (value){setState(() {
                                 reciept=value!;
                               });}),
                                Text(
                                  'Reciept',
                                  style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    activeColor: appDarkColor,
                                    value: legit, onChanged: (value){setState(() {
                                  legit=value!;
                                });}),
                                Text(
                                  'Legit check',
                                  style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    activeColor: appDarkColor,
                                    value: laces, onChanged: (value){setState(() {
                                  laces=value!;
                                });}),
                                Text(
                                  'Laces',
                                  style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.image);
                      if (result != null) {
                        result.files.forEach((element) {
                          productImagesResults.add(element);
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image(image: AssetImage('assets/images/upload 1.png'),)),
                          SizedBox(width: 10,),
                          Text(
                            'Upload Product Images',
                            style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.black)),
                          )
                        ],
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomButton(text: 'Add Product', onPressed: () {
                    var chk;
                    SharedPreferences.getInstance().then((value) {
                      chk = value.getBool('logined');
                      if (chk == false) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => loginView()));
                      }
                      else if (items.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please select images');
                      }
                      else {
                        addProduct();
                      }
                    });
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  addProduct()async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(padding:EdgeInsets.symmetric(horizontal: 50),child: Center(child: new LinearProgressIndicator())),
              SizedBox(height: 10,),
              Text('Please wait...')
            ],
          ),
        );

      },
    );
   uploadPic().then((value) => {
     Future.delayed(Duration(seconds:10)).then((value) =>
     {
                FirebaseFirestore.instance.collection('products').add({
                  'title': title.text,
                  'price': price.text,
                  'condition': selectedValue,
                  'address': address.text,
                  'model': model.text,
                  'box': box,
                  'reciept': reciept,
                  'legitCheck': legit,
                  'laces':laces,
                  'images': FieldValue.arrayUnion(productImagesLinks),
                  'sellerId':FirebaseAuth.instance.currentUser!.uid
                }),
                Navigator.of(context).pop(),
                productImagesResults.clear(),
                productImagesLinks.clear(),
                Fluttertoast.showToast(msg: 'Product Uploaded'),
              })
   });

  }
  Future uploadPic() async {
    productImagesResults.forEach((element) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('products').child(element.name);
      await ref.putFile(File(element.path!));
      var imageUrl = await ref.getDownloadURL();
      productImagesLinks.add(imageUrl);
    });
  }
}
