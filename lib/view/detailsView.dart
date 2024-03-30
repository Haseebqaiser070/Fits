import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fits_daxno/Constants/Theme.dart';
import 'package:fits_daxno/Constants/constants.dart';
import 'package:fits_daxno/model/productModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_preview/image_preview.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'chatInbox.dart';

class detailsView extends StatefulWidget {
  detailsView({Key, key,this.model,this.id}) : super(key: key);
  var id;
  product_model ?model;
  @override
  _detailsViewState createState() => _detailsViewState();
}

class _detailsViewState extends State<detailsView> {
  List<String> images=[];
  PageController pageController=new PageController();
  @override
  void initState() {
    widget.model?.images!=null?widget.model?.images!.forEach((element) {
      images.add(element.toString());
    }):null;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
               Container(
                 height: sh * 0.5,
                 child: PageView.builder(
                     controller: pageController,
                     itemCount: widget.model?.images!=null?widget.model!.images!.length:0,
                     itemBuilder: (context,index){
                   return Container(child: InkWell(
                     onTap:(){
                       openImagesPage(Navigator.of(context),
                         imgUrls: widget.model?.images!=null?images:["https://firebasestorage.googleapis.com/v0/b/fits-acae5.appspot.com/o/no-photo-available-icon-8.jpg?alt=media&token=d4484c42-2771-4529-9a37-1c92c72a470c"],
                       );
                     },
                     child: Container(
                       height: sh * 0.5,
                       width: sw,
                       decoration: BoxDecoration(
                           image: DecorationImage(
                               image: NetworkImage('${widget.model?.images!=null?widget.model!.images!.elementAt(index):"https://firebasestorage.googleapis.com/v0/b/fits-acae5.appspot.com/o/no-photo-available-icon-8.jpg?alt=media&token=d4484c42-2771-4529-9a37-1c92c72a470c"}'),
                               fit: BoxFit.fill)),
                     ),
                   ));
                 }),
               ),
                Container(
                  width: sw,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ]),
                  child: Column(
                    children: [
                     Row(
                       children: [
                         Container(
                           height: 100,
                            width: sw*0.8,
                            child: ListView.builder(
                              itemCount:  widget.model?.images!=null?widget.model!.images!.length:0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left:5),
                                child: InkWell(
                                  onTap: (){
                                      pageController.jumpTo(index+0.0);
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.fill,image: NetworkImage('${widget.model?.images!=null?widget.model!.images!.elementAt(index):"https://firebasestorage.googleapis.com/v0/b/fits-acae5.appspot.com/o/no-photo-available-icon-8.jpg?alt=media&token=d4484c42-2771-4529-9a37-1c92c72a470c"}'),
                                      )
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                         SizedBox(width:5,),
                         GestureDetector(
                           onTap: (){
                             pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInToLinear);
                           },
                           child: Icon(
                             Icons.play_arrow,
                             color: Colors.black,
                           ),
                         )
                       ],
                     ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            controller: pageController,
                            count: widget.model?.images!=null?widget.model!.images!.length:0,
                            axisDirection: Axis.horizontal,
                            effect:  SlideEffect(
                                spacing:  8.0,
                                radius:  4.0,
                                dotWidth:  15.0,
                                dotHeight:  1,
                                paintStyle:  PaintingStyle.stroke,
                                strokeWidth:  1.5,
                                dotColor:  Colors.grey,
                                activeDotColor:  Colors.black
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: sw,
                        child: Text(
                          '${widget.model?.title!=null?widget.model?.title:""}',
                          maxLines: 3,
                          style: GoogleFonts.workSans(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '£${widget.model?.price!=null?widget.model?.price:""} ',
                                maxLines: 3,
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ],
                          ),
                          Text(
                            'Condition: ${widget.model?.condition!=null?widget.model?.condition.toString().toUpperCase():""}',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: Colors.red.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: sw,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 0))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Recipt: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.reciept!=null?widget.model!.reciept==true?"Available":"Not Available":""}',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Shoe Box: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.box!=null?widget.model!.box==true?"Available":"Not Available":""}',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Legit check: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.legitCheck!=null?widget.model!.legitCheck==true?"Available":"Not Available":""}',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Laces: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.laces!=null?widget.model!.laces==true?"Available":"Not Available":""}',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: sw,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 0))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Model number: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.model!=null?widget.model!.model:""}',
                            maxLines: 10,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  width: sw,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 0))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Address: ',
                            maxLines: 3,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Text(
                            '${widget.model?.address!=null?widget.model!.address:""}',
                            maxLines: 10,
                            style: GoogleFonts.workSans(
                                textStyle: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users').doc(widget.model!.sellerId.toString()).get(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Container(
                          width: sw,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 0))
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${snapshot.data?['image']}'),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data?['username']}',
                                        maxLines: 3,
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Gender:${snapshot.data?['gender']}',
                                    maxLines: 3,
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  Text(
                                    'Age: ${snapshot.data?['age']}',
                                    maxLines: 3,
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 60,
              width: sw,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 0))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: (){
    if (widget.model!.sellerId ==
    FirebaseAuth
        .instance
        .currentUser!
        .uid) {
    Fluttertoast
        .showToast(
    msg: 'This is your product');
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          chatInbox(recieverId: widget.model!.sellerId,)));
    }
    },
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Text(
                            'Chat with Seller',
                            style: GoogleFonts.workSans(
                                textStyle:
                                    TextStyle(color: appTextColor, fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
