import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fits_daxno/Constants/Theme.dart';
import 'package:fits_daxno/Constants/constants.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:fits_daxno/model/productModel.dart';
import 'package:fits_daxno/view/chatInbox.dart';
import 'package:fits_daxno/view/detailsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'contactUs.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key, key}) : super(key: key);

  @override
  _ViewAllState createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  void initState() {
    productList=GetAllProducts();
    addlist();
    // TODO: implement initState
    super.initState();
  }
  addlist()async{
    searchList=await productList;
  }
  Future<List<product_model>>? productList;
  List<product_model> ?searchList=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                height: sh,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 40,
                                    offset: Offset(0, 10)),
                              ]),
                          child: CustomTextFields(
                            onchanged:  (value1){
                              productList!.then((value) =>
                              {
                                setState(() {
                                  searchList=  value.where((element) => element.title!.toLowerCase().contains(value1.toLowerCase())).toList();
                                  // value.sort((a, b) => a.title!.compareTo(searchTitle.text));
                                })
                              });
                            },
                            hintText: 'What are you looking for?',
                            hintColor: Colors.grey,
                            borderradius: 100.0,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child:FutureBuilder(
                            future: productList,
                            builder: (context, snapshot) {
                              if(snapshot.hasData)
                                return GridView.builder(
                                    itemCount: searchList!.length,
                                    gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 1.7 / 3,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>detailsView(model:searchList!.elementAt(index),)));
                                        },
                                        child: Container(
                                          width: 160,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage("${searchList!.elementAt(index).images!.isNotEmpty?searchList!.elementAt(index).images!.first.toString():"https://firebasestorage.googleapis.com/v0/b/fits-acae5.appspot.com/o/no-photo-available-icon-8.jpg?alt=media&token=d4484c42-2771-4529-9a37-1c92c72a470c"}"),fit: BoxFit.fill),
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  '${searchList!.elementAt(index).title!=null?searchList!.elementAt(index).title:""}',
                                                  maxLines: 3,
                                                  style: GoogleFonts.workSans(
                                                      textStyle:
                                                      TextStyle(color: Colors.black)),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '£${searchList!.elementAt(index).price!=null?searchList!.elementAt(index).price:"0"}',
                                                        maxLines: 3,
                                                        style: GoogleFonts.workSans(
                                                            textStyle: TextStyle(
                                                                color:
                                                                Colors.red.shade600,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (searchList!
                                                          .elementAt(index)
                                                          .sellerId ==
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid) {
                                                        Fluttertoast
                                                            .showToast(
                                                            msg: 'This is your product');
                                                      } else {
                                                        Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    chatInbox(
                                                                      recieverId: searchList!
                                                                          .elementAt(
                                                                          index)
                                                                          .sellerId,)));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 5, horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(100),
                                                          color: Colors.lightBlue),
                                                      child: Text(
                                                        'Chat',
                                                        maxLines: 3,
                                                        style: GoogleFonts.workSans(
                                                            textStyle: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              else{
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(height: 30,width: 30,child: CircularProgressIndicator(),),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<List<product_model>> GetAllProducts()async{
    List<product_model> list=[];
    QuerySnapshot data=await FirebaseFirestore.instance.collection('products').get();
    data.docs.forEach((element) {
      list.add(product_model.fromJson(jsonDecode(jsonEncode(element.data()).toString())));
    });
    return list;
  }
}
