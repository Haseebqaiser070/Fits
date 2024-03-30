import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fits_daxno/Constants/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';
import '../model/message_Model.dart';


class recievedMessageWidget extends StatefulWidget {
  recievedMessageWidget({Key ,key,this.message_model}) : super(key: key);
  message_Model ?message_model;

  @override
  _recievedMessageWidgetState createState() => _recievedMessageWidgetState();
}

class _recievedMessageWidgetState extends State<recievedMessageWidget> {
  Timestamp time=new Timestamp(100, 100);
  @override
  void initState() {
    time=widget.message_model!.createdAt;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 1,
                      blurRadius: 20
                  )],
                ),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      margin: EdgeInsets.only(right: 50,left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: widget.message_model?.fileUrl!=null &&  widget.message_model?.messagetype=='jpg' || widget.message_model?.messagetype=='png' || widget.message_model?.messagetype=='jpeg',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network('${widget.message_model?.fileUrl}',fit: BoxFit.fill,),
                            ),
                          ),
                          Visibility(
                            visible: widget.message_model?.fileUrl!=null &&  widget.message_model?.messagetype=='docx' || widget.message_model?.messagetype=='doc' || widget.message_model?.messagetype=='txt'|| widget.message_model?.messagetype=='xlsx',
                            child: Container(
                              height: 60,
                              width: sw,
                              decoration: BoxDecoration(
                                  color: Colors.grey
                              ),
                              child: Center(child: Text('${widget.message_model?.messagetype} File',style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                          Visibility(
                              visible: widget.message_model?.fileUrl!=null,child:SizedBox(height: 10,)),
                          Text(
                              "${widget.message_model?.messageBody==null?"":widget.message_model!.messageBody}",
                              style: GoogleFonts.domine(textStyle:TextStyle(color: Colors.black, fontSize: 14),)
                          ),
                          SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${DateTime.fromMicrosecondsSinceEpoch(int.parse(time.microsecondsSinceEpoch.toString())).hour<12?'0':""}${DateTime.fromMicrosecondsSinceEpoch(int.parse(time.microsecondsSinceEpoch.toString())).hour}:${DateTime.fromMicrosecondsSinceEpoch(int.parse(time.microsecondsSinceEpoch.toString())).minute<10?"0":""}${DateTime.fromMicrosecondsSinceEpoch(int.parse(time.microsecondsSinceEpoch.toString())).minute}",
                                style:GoogleFonts.domine(textStyle: TextStyle(color: Colors.black38, fontSize: 10)),
                              )
                            ],
                          )
                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
