import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:fits_daxno/Widgets/SearchField.dart';
import 'package:fits_daxno/model/message_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';
import 'chatInbox.dart';

class conversationsView extends StatefulWidget {
  conversationsView({Key ,key}) : super(key: key);

  @override
  _conversationsViewState createState() => _conversationsViewState();
}

class _conversationsViewState extends State<conversationsView> {
  var text="Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with: “Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.” The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content. The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-";
TextEditingController searchController=new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Container(
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
                          Text("Conversations",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 18)),),
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
                SizedBox(height: 20,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                       Row(children: [
                         Expanded(child: Container(
                           height: 50,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.white
                             ),
                             child: SearchTextFields(prefixIcon: Icon(Icons.search),hintText: 'Search...',onchanged: (value){
                               setState(() {
                             });},controller:searchController,))),
                        SizedBox(width: 30,),
                         FutureBuilder<DocumentSnapshot>(
                           future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
                           builder: (context,snapshot) {
                             return Container(
                               height: 50,
                               width: 50,
                               decoration: BoxDecoration(
                                 color: Colors.grey,
                                 image: DecorationImage(
                                     image:NetworkImage(
                                         '${snapshot.data?['image']}'),
                                     fit: BoxFit.fill
                                 ),
                                 shape: BoxShape.circle,
                               ),
                             );
                           }
                         ),

                       ],)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      future:  FirebaseFirestore.instance.collection('chats').doc(FirebaseAuth.instance.currentUser!.uid).collection('users').get(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          List list=[];
                          list.isEmpty?list=List.generate(snapshot.data!.docs.length, (index) => false):null;
                          return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                          return FutureBuilder<DocumentSnapshot>(
                                future:  FirebaseFirestore.instance.collection('users').doc(snapshot.data!.docs.elementAt(index).id).get(),
                                builder: (context, userSnapshot) {
                               if(userSnapshot.data?['username'].toString().toLowerCase().contains(searchController.text.toLowerCase())==true) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        chatInbox(
                                                          recieverId: snapshot
                                                              .data!.docs
                                                              .elementAt(index)
                                                              .id,
                                                        )));
                                          },
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Container(
                                                    height: 250,
                                                    padding: EdgeInsets.all(20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            height: 50,
                                                            width: 50,
                                                            child: Image(
                                                              image: AssetImage(
                                                                  'assets/images/vector.png'),
                                                            )),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Delete message?',
                                                                  style: GoogleFonts.roboto(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Do you really want to delete this',
                                                                  style: GoogleFonts.roboto(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'conversation?',
                                                                  style: GoogleFonts.roboto(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              sw),
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20.0,
                                                                        vertical:
                                                                            5),
                                                                    child: Text(
                                                                      'Cancel   ',
                                                                      style: GoogleFonts.roboto(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 14)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'chats')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          'users')
                                                                      .doc(userSnapshot
                                                                          .data!
                                                                          .id)
                                                                      .delete();
                                                                  QuerySnapshot
                                                                      data =
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'messages')
                                                                          .get();
                                                                  data.docs.forEach(
                                                                      (element) {
                                                                    if ((element['recieverId'] == userSnapshot.data!.id &&
                                                                            element['senderId'] ==
                                                                                FirebaseAuth
                                                                                    .instance.currentUser!.uid) ||
                                                                        (element['recieverId'] == FirebaseAuth.instance.currentUser!.uid &&
                                                                            element['senderId'] ==
                                                                                userSnapshot.data!.id)) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'messages')
                                                                          .doc(element
                                                                              .id)
                                                                          .delete();
                                                                    }
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          appColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              sw),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors
                                                                                .grey,
                                                                            spreadRadius:
                                                                                0.5,
                                                                            blurRadius:
                                                                                2,
                                                                            offset:
                                                                                Offset(0, 3))
                                                                      ]),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20.0,
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        'Delete',
                                                                        style: GoogleFonts.workSans(
                                                                            textStyle:
                                                                                TextStyle(color: appTextColor, fontSize: 14)),
                                                                      ),
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
                                                );
                                              },
                                            );
                                            for (int i = 0;
                                                i < list.length;
                                                i++) {
                                              list[i] = false;
                                            }
                                            list[index] = true;
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                FutureBuilder<DocumentSnapshot>(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(snapshot.data!.docs
                                                            .elementAt(index)
                                                            .id)
                                                        .get(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  '${snapshot.data?['image']}'),
                                                              fit: BoxFit.fill),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      );
                                                    }),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: sw * 0.75,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${userSnapshot.data?['username']}",
                                                            style: GoogleFonts.workSans(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14)),
                                                          ),
                                                          Text(
                                                            "${DateTime.fromMicrosecondsSinceEpoch(int.parse(snapshot.data!.docs.elementAt(index)['createdAt'].microsecondsSinceEpoch.toString())).hour < 12 ? '0' : ""}${DateTime.fromMicrosecondsSinceEpoch(int.parse(snapshot.data!.docs.elementAt(index)['createdAt'].microsecondsSinceEpoch.toString())).hour}:${DateTime.fromMicrosecondsSinceEpoch(int.parse(snapshot.data!.docs.elementAt(index)['createdAt'].microsecondsSinceEpoch.toString())).minute < 10 ? "0" : ""}${DateTime.fromMicrosecondsSinceEpoch(int.parse(snapshot.data!.docs.elementAt(index)['createdAt'].microsecondsSinceEpoch.toString())).minute}",
                                                            style: GoogleFonts.workSans(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10)),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .checkDouble,
                                                            size: 10,
                                                            color: appColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: sw * 0.5,
                                                            child: Text(
                                                              "${snapshot.data!.docs.elementAt(index)['messageBody']}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: list.elementAt(index),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 40,
                                              width: 30,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red.shade100,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  CupertinoIcons.delete,
                                                  color: Colors.red.shade900,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }else{
                                 return Container();
                               }
                                }
                            );
                          }
                        );
                    }else{
                  return Container();
                  }
                      }
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
