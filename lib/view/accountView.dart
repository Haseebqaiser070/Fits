import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:fits_daxno/view/bottomNavigationBar.dart';
import 'package:fits_daxno/view/tokenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';

class accountView extends StatefulWidget {
  const accountView({Key, key}) : super(key: key);

  @override
  _accountViewState createState() => _accountViewState();
}

class _accountViewState extends State<accountView> {
  var imageUrl = '';
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Container(
                      height: sh,
                      width: sw,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: sh * 0.43,
                            ),
                            CustomTextFields(
                              controller: nameController,
                              hintColor: Colors.white,
                              hintText: '${snapshot.data?['username']}',
                              prefixIcon: Icon(
                                CupertinoIcons.person_circle,
                                color: Colors.black,
                              ),
                              fillColor: appColor,
                            ),
                            CustomTextFields(
                              controller: emailController,
                              hintColor: Colors.white,
                              hintText: '${snapshot.data?['email']}',
                              prefixIcon: Icon(
                                CupertinoIcons.mail_solid,
                                color: Colors.black,
                              ),
                              fillColor: appColor,
                            ),
                            CustomTextFields(
                              controller: phoneController,
                              hintColor: Colors.white,
                              hintText: '${snapshot.data?['phone']}',
                              prefixIcon: Icon(
                                Icons.perm_contact_cal,
                                color: Colors.black,
                              ),
                              fillColor: appColor,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFields(
                                    controller: ageController,
                                    hintColor: Colors.white,
                                    hintText: '${snapshot.data?['age']}',
                                    prefixIcon: Icon(
                                      CupertinoIcons.person_3_fill,
                                      color: Colors.black,
                                    ),
                                    fillColor: appColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: CustomTextFields(
                                    controller: genderController,
                                    hintColor: Colors.white,
                                    hintText: '${snapshot.data?['gender']}',
                                    prefixIcon: Icon(
                                      CupertinoIcons.person_circle,
                                      color: Colors.black,
                                    ),
                                    fillColor: appColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                saveData();
                              },
                              child: Container(
                                width: 140,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(sw),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5),
                                    child: Text(
                                      'Edit Profile',
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              color: appTextColor,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: sh * 0.3,
                      width: sw,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(sw * 0.2),
                              bottomLeft: Radius.circular(sw * 0.2))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.notifications,
                                            color: Colors.yellow,
                                            size: 30,
                                          )),
                                      Positioned(
                                        right: 5,
                                        top: 10,
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                            '1',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<DropdownMenuItem>(
                                      customButton: const Icon(
                                        Icons.more_vert,
                                      ),
                                      customItemsIndexes: const [3],
                                      customItemsHeight: 8,
                                      items: [
                                        DropdownMenuItem(
                                            child: InkWell(
                                          child: InkWell(
                                            onTap: () async {
                                              FirebaseAuth.instance.signOut();
                                              GoogleSignIn().signOut();
                                              logined = false;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool('logined', false);
                                              bottomBarState.selectedIndex = 0;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          bottomBar()));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.logout,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'logout',
                                                  style: GoogleFonts.workSans(
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                      onChanged: (value) {},
                                      itemHeight: 48,
                                      itemPadding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      dropdownWidth: 160,
                                      dropdownPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 6),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      dropdownElevation: 8,
                                      offset: const Offset(0, 8),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                allowMultiple: false,
                                                type: FileType.image);
                                        if (result != null) {
                                          FirebaseStorage storage =
                                              FirebaseStorage.instance;
                                          Reference ref = storage
                                              .ref()
                                              .child('products')
                                              .child(DateTime.now().toString());
                                          await ref.putFile(
                                              File(result.files.first.path!));
                                          imageUrl = await ref.getDownloadURL();
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            padding: EdgeInsets.all(5),
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${snapshot.data?['image']}'),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                          Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Icon(
                                                Icons.add_circle_sharp,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "  ${snapshot.data?['username']}",
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    SizedBox()
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: sh * 0.2,
                        left: sw * 0.1,
                        right: sw * 0.1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tokens Remaning",
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ),
                                  // Icon(Icons.more_horiz,color: Colors.black,),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${snapshot.hasData?snapshot.data!['token']:"0"} Tokens",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: appColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => tokenView()));
                                },
                                child: Container(
                                  width: 140,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(sw),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 0.5,
                                            blurRadius: 2,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5),
                                      child: Text(
                                        'Buy Tokens',
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                color: appTextColor,
                                                fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  ],
                );
              }
            }),
      ),
    ));
  }

  saveData() async {
    var auth = await FirebaseAuth.instance;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    var age = '';
    var phone = '';
    var password = '';
    var name = '';
    var gender = '';
    var image = '';
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
      token=userdata['token'];
    } catch (ex) {}
    var temp = await collectionReference.doc(auth.currentUser!.uid).set({
      'email': auth.currentUser!.email,
      'password': password,
      'phone': phoneController.text.isEmpty?phone:phoneController.text,
      'username': nameController.text.isEmpty ?name:nameController.text,
      'age': ageController.text.isEmpty?age:ageController.text,
      'gender': genderController.text.isEmpty?gender:genderController.text,
      'image': imageUrl.isEmpty ?image:imageUrl,
      'token': token.toString().isEmpty?0:token,
    }).then((value) => {
      Fluttertoast.showToast(msg: 'Profile updated'),
    });
  }
}
