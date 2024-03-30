import 'package:fits_daxno/Constants/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';
class SearchTextFields extends StatelessWidget {
  SearchTextFields(
      {this.controller,
        this.height,
        this.hintText,
        this.label,
        this.onchanged,this.onsaved,this.suffixIcon,this.prefixIcon,this.fillColor,this.filled});
  var height;
  var hintText;
  var label;
  var onchanged;
  var onsaved;
  var controller;
  var suffixIcon;
  var prefixIcon;
  var fillColor;
  var filled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5),
      child: Container(
        height: 50,
        child: TextFormField(
          cursorColor: appColor,

          // cursorWidth: 20,
          decoration: InputDecoration(
            fillColor: fillColor??fillColor,
            filled: filled??filled,
            prefixIcon:prefixIcon??prefixIcon,
            suffixIcon: suffixIcon??suffixIcon,
            disabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            hintText: hintText ?? hintText,
            hintStyle: GoogleFonts.workSans(textStyle: TextStyle(color: Colors.grey,)),
            // hintStyle: TextStyle()
          ),
          onChanged: onchanged ?? onchanged,
          onSaved: onsaved ?? onsaved,
          controller: controller ?? controller,
        ),
      ),
    );
  }
}
