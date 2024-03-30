import 'package:fits_daxno/Constants/Theme.dart';
import 'package:fits_daxno/Constants/constants.dart';
import 'package:fits_daxno/view/Home.dart';
import 'package:fits_daxno/view/accountView.dart';
import 'package:fits_daxno/view/addProductView.dart';
import 'package:fits_daxno/view/conditionsView.dart';
import 'package:fits_daxno/view/contactUs.dart';
import 'package:fits_daxno/view/conversationsView.dart';
import 'package:fits_daxno/view/loginView.dart';
import 'package:fits_daxno/view/tokenView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({Key, key}) : super(key: key);

  @override
  bottomBarState createState() => bottomBarState();
}

class bottomBarState extends State<bottomBar> {
  static var selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    homeView(),
    tokenView(),
    conversationsView(),
   accountView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        child:Icon(Icons.add_circle_sharp,size:50,color: appColor,), onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addProductView()));
      },
      ),
      bottomNavigationBar:Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(10, 0))
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: bottomBarItem(
                              icon: Icon(
                                Icons.home_outlined,
                                color: selectedIndex == 0 ? appColor : Colors.grey,
                              ),
                              label: Text(
                                'Home',
                                style: GoogleFonts.workSans(
                                  fontSize:14,
                                  color: selectedIndex == 0 ? appColor : Colors.grey,
                                ),
                              ),
                            ))),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: bottomBarItem(
                              icon: Icon(
                                CupertinoIcons.rectangle_grid_2x2,
                                size: 23,
                                color: selectedIndex == 1 ? appColor : Colors.grey,
                              ),
                              label: Text(
                                'Buy Plan',
                                style: GoogleFonts.workSans(
                                  fontSize:14,
                                  color: selectedIndex == 1 ? appColor : Colors.grey,
                                ),
                              ),
                            ))),
                    Expanded(
                        child: InkWell(
                            onTap: (){
                              var chk;
                              SharedPreferences.getInstance().then((value) {chk= value.getBool('logined');
                              setState(() {
                                if(chk==true){
                                selectedIndex = 2;
                                }else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>loginView()));
                                }
                              });
                              });
                            },
                            child: bottomBarItem(
                              icon: Icon(
                                Icons.message_outlined,
                                color: selectedIndex == 2 ? appColor : Colors.grey,
                              ),
                              label: Text(
                                'Chat',
                                style: GoogleFonts.workSans(
                                  fontSize:14,
                                  color: selectedIndex == 2 ? appColor : Colors.grey,
                                ),
                              ),
                            ))),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              var chk;
                              SharedPreferences.getInstance().then((value) {chk= value.getBool('logined');
                              setState(() {
                                if(chk==true){
                                  selectedIndex = 3;
                                }else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>loginView()));
                                }
                              });
                              });
                            },
                            child: bottomBarItem(
                              icon: Icon(
                                CupertinoIcons.person,
                                color: selectedIndex == 3 ? appColor : Colors.grey,
                              ),
                              label: Text(
                                'Account',
                                style: GoogleFonts.workSans(
                                  fontSize:14,
                                  color: selectedIndex == 3 ? appColor : Colors.grey,
                                ),
                              ),
                            ))),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      InkWell( onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>conditionsView()));
                      },child: Text('Terms and Conditions',style: GoogleFonts.workSans(color: appColor,fontSize: 10),)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(selectedIndex),
    );
  }
}

class bottomBarItem extends StatelessWidget {
  bottomBarItem({this.label, this.icon});
  var icon;
  var label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, label],
    );
  }
}
