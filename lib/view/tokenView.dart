import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';
import '../Widgets/CustomTextFields.dart';

class tokenView extends StatefulWidget {
  const tokenView({Key, key}) : super(key: key);

  @override
  _tokenViewState createState() => _tokenViewState();
}

class _tokenViewState extends State<tokenView> {
  List<PaymentItem> _paymentItems = [];
  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
  List<token> list = [
    token(
      price: 2,
      quantity: 1,
    ),
    token(
      price: 5,
      quantity: 3,
    ),
    token(
      price: 8,
      quantity: 5,
    ),
    token(
      price: 10,
      quantity: 10,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
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

                    Text(
                      "Purchase Token",
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
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
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  "Post Your Product for 30 Days",
                  style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: Color(0xff25335A),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('plans').get(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // showModalBottomSheet(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return Container(
                          //         padding: EdgeInsets.all(10),
                          //         color: Color(0xff1C253E),
                          //         child: Column(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Container(
                          //               child: Column(
                          //                 children: [
                          //                   Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       Text(
                          //                         "Apple Pay",
                          //                         style: GoogleFonts.workSans(
                          //                             textStyle: TextStyle(
                          //                                 color: Colors.white,
                          //                                 fontWeight:
                          //                                     FontWeight.bold,
                          //                                 fontSize: 18)),
                          //                       ),
                          //                       InkWell(
                          //                           onTap: () {
                          //                             Navigator.of(context).pop();
                          //                           },
                          //                           child: Text(
                          //                             "Cancel",
                          //                             style: GoogleFonts.workSans(
                          //                                 textStyle: TextStyle(
                          //                                     color: appColor,
                          //                                     fontSize: 18)),
                          //                           )),
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 30,
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       Container(
                          //                         width: 100,
                          //                         child: Row(
                          //                           mainAxisAlignment: MainAxisAlignment.end,
                          //                           children: [
                          //                             Container(
                          //                               width: 40,
                          //                               height: 40,
                          //                             decoration: BoxDecoration(
                          //                               color: Colors.white,
                          //                               borderRadius: BorderRadius.circular(5),
                          //                             ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(width: 10,),
                          //                       Container(
                          //                         height: 40,
                          //                         child: Column(
                          //                           crossAxisAlignment: CrossAxisAlignment.start,
                          //                           mainAxisAlignment: MainAxisAlignment.start,
                          //                           children: [
                          //                             Text(
                          //                               "${snapshot.data!.docs.elementAt(index)['token']} tokens",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                             Text(
                          //                               "Your App — Description",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.grey,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Divider(
                          //                     height: 1,
                          //                     color: Colors.grey,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         width: 100,
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.end,
                          //                           children: [
                          //                             Text(
                          //                               "DETAILS",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Expanded(
                          //                         child: Text(
                          //                           "${snapshot.data!.docs.elementAt(index)['description']}",
                          //                           style: GoogleFonts.workSans(
                          //                               textStyle: TextStyle(
                          //                                   color: Colors.white,
                          //                                   fontSize: 14)),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Divider(
                          //                     height: 1,
                          //                     color: Colors.grey,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         width: 100,
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.end,
                          //                           children: [
                          //                             Text(
                          //                               "ACCOUNT",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Expanded(
                          //                         child: Text(
                          //                           "subs@mail.com",
                          //                           style: GoogleFonts.workSans(
                          //                               textStyle: TextStyle(
                          //                                   color: Colors.white,
                          //                                   fontSize: 14)),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Divider(
                          //                     height: 1,
                          //                     color: Colors.grey,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         width: 100,
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.end,
                          //                           children: [
                          //                             Text(
                          //                               "Period",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Expanded(
                          //                         child: Text(
                          //                           "${snapshot.data!.docs.elementAt(index)['period']}",
                          //                           style: GoogleFonts.workSans(
                          //                               textStyle: TextStyle(
                          //                                   color: Colors.white,
                          //                                   fontSize: 14)),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         width: 100,
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.end,
                          //                           children: [
                          //                             Text(
                          //                               "Price",
                          //                               style: GoogleFonts.workSans(
                          //                                   textStyle: TextStyle(
                          //                                       color: Colors.white,
                          //                                       fontSize: 14)),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           Text(
                          //                             "${snapshot.data!.docs.elementAt(index)['price']} \$",
                          //                             style: GoogleFonts.workSans(
                          //                                 textStyle: TextStyle(
                          //                                     color: Colors.white,
                          //                                     fontSize: 14)),
                          //                           ),
                          //
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Divider(
                          //                     height: 1,
                          //                     color: Colors.grey,
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //             Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Image(
                          //                   image: AssetImage(
                          //                     'assets/images/back.png',
                          //                   ),
                          //                 ),
                          //                 SizedBox(height:10),
                          //                 Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.center,
                          //                     children: [
                          //                       Text(
                          //                         "Confirm with Side Button",
                          //                         style: GoogleFonts.workSans(
                          //                             textStyle: TextStyle(
                          //                                 color: Colors.white,
                          //
                          //                                 fontSize: 18)),
                          //                       ),
                          //                     ])
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xff25335A),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${snapshot.data!.docs.elementAt(index)['token']} token",
                                    style: GoogleFonts.workSans(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: appColor,
                                  //     borderRadius: BorderRadius.circular(sw),
                                  //   ),
                                  //   child: Center(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 10.0, vertical: 5),
                                  //       child: Text(
                                  //         'Buy Now',
                                  //         style: GoogleFonts.workSans(
                                  //             textStyle: TextStyle(
                                  //                 color: appTextColor,
                                  //                 fontSize: 14)),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                  ApplePayButton(
                                    height: 30,
                                    width: 100,
                                    paymentConfigurationAsset: 'apple-pay.json',
                                    paymentItems: [PaymentItem(
                                      label: 'Total',
                                      amount: '${snapshot.data!.docs.elementAt(index)['price']}',
                                      status: PaymentItemStatus.final_price,
                                    )],
                                    style:ApplePayButtonStyle.white,
                                    type: ApplePayButtonType.buy,
                                    margin: const EdgeInsets.only(top: 15.0),
                                    onPaymentResult: onApplePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  GooglePayButton(
                                    height: 40,
                                    width: 100,
                                    paymentConfigurationAsset: 'google-pay.json',
                                    paymentItems: [PaymentItem(
                                      label: 'Total',
                                      amount: '${snapshot.data!.docs.elementAt(index)['price']}',
                                      status: PaymentItemStatus.final_price,
                                    )],
                                    style: GooglePayButtonStyle.white,
                                    type: GooglePayButtonType.buy,
                                    margin: const EdgeInsets.only(top: 15.0),
                                    onPaymentResult: onGooglePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${snapshot.data!.docs.elementAt(index)['price']}",
                                style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }else{
                  return Column(mainAxisAlignment: MainAxisAlignment.center,children: [Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Container(height: 30,width: 30,child: CircularProgressIndicator(),)
                  ],)],);
                }
              }
            ),
          )
        ],
      ),
    ));
  }
}

class token {
  var price;
  var quantity;
  token({this.price, this.quantity});
}
