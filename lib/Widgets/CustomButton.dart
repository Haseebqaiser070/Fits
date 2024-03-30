import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Theme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text,required this.onPressed});
  var onPressed;
  var text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:onPressed??onPressed,//onPressed ?? onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
            primary: appDarkColor,
            elevation: 0
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
              child: Text(
                text!=null?text:"",
                style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15
                    )),
              )),
        ));
  }
}
class CustomgroupButton extends StatelessWidget {
  CustomgroupButton({required this.text,required this.onPressed});
  var onPressed;
  var text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: ElevatedButton(
          onPressed:onPressed??onPressed,//onPressed ?? onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              primary: appDarkColor,
              elevation: 0
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
                  text!=null?text:"",
                  style: GoogleFonts.domine(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                )),
          )),
    );
  }
}
