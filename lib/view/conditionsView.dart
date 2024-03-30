import 'package:fits_daxno/Widgets/CustomButton.dart';
import 'package:fits_daxno/Widgets/CustomTextFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Theme.dart';
import '../Constants/constants.dart';

class conditionsView extends StatefulWidget {
  const conditionsView({Key ,key}) : super(key: key);

  @override
  _conditionsViewState createState() => _conditionsViewState();
}

class _conditionsViewState extends State<conditionsView> {
  var text="Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with: “Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.” The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content. The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Container(
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
                          Text("Term & Conditions",style: GoogleFonts.workSans(textStyle: TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 18)),),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        SizedBox(height: 50,),
                        Expanded(child: SingleChildScrollView(child: Text(text,style: GoogleFonts.workSans(color: Colors.black),))),
                        SizedBox(height: 50,),
                        CustomButton(text: 'Accept', onPressed: (){}),
                        SizedBox(height: 30,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
