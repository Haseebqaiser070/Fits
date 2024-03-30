
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fits_daxno/view/loginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/Theme.dart';
import '../Constants/constants.dart';
import '../Widgets/SearchField.dart';
import '../Widgets/recievedMessageWidget.dart';
import '../Widgets/sendMessageWidget.dart';
import '../controller/chatService_ontroller.dart';
import '../model/message_Model.dart';

class chatInbox extends StatefulWidget {
   chatInbox({Key ,key,required this.recieverId}) : super(key: key);
  var recieverId;
  @override
  _chatInboxState createState() => _chatInboxState();
}

class _chatInboxState extends State<chatInbox> {
  var file;
  var name;
  var imageUrl;
  bool picked=false;
  bool typeImage=false;
  bool typefile=false;
  var extention;
  var Filename;
  TextEditingController messageBodyController=new TextEditingController();
  ScrollController controller=new ScrollController();
  @override
  void initState() {
    logined!=true?Navigator.of(context).push(MaterialPageRoute(builder: (context)=>loginView())):null;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 100,
                width: sw,
                color: appColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       SizedBox(width:40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance.collection('users').doc(widget.recieverId.toString()).get(),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                return Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${snapshot.data?['image']}'),
                                              fit: BoxFit.fill)),
                                    ),
                                    Text(
                                      " ${snapshot.data?['username']}",
                                      style: GoogleFonts.workSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                );}else{
                                  return Container();
                                }
                              }
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

                  ],
                ),
              ),
              Visibility(
                visible: !picked,
                child: Expanded(
                    child: Container(
                      child:Container(
                          height: sh*0.8,
                          child:StreamBuilder<List<message_Model>>(
                              stream: chatService_controller().GetRealTimeMessage(widget.recieverId),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  return ListView.builder(
                                      reverse: true,
                                      controller: controller,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (context, index) {
                                        if(snapshot.data!.elementAt(index).senderId==FirebaseAuth.instance.currentUser!.uid) {
                                          return  sendMessageWidget(message_model: snapshot.data!.elementAt(index),);

                                        } else {
                                          return recievedMessageWidget(message_model: snapshot.data!.elementAt(index));                                   }
                                      }
                                  );}else{
                                  return Container();
                                }
                              }
                          )
                      ),
                    )),
              ),
              file!=null?Visibility(
                visible: picked && typeImage,
                child: Expanded(
                    child: Container(
                      child:Container(
                          height: sh*0.8,
                          width: sw,
                          child:Stack(
                            children: [
                              Container( height: sh*0.8,
                                  width: sw,child: Image.file(File(file),fit: BoxFit.fill,)),
                              Positioned(
                                right: 20,
                                child: IconButton(onPressed: (){
                                  setState(() {
                                    picked=false;
                                    typefile=false;
                                    typeImage=false;
                                  });
                                }, icon: Icon(
                                  Icons.cancel_outlined,color: Colors.black,
                                  size: 50,
                                )),
                              )
                            ],
                          )
                      ),
                    )),
              ):Container(),
              file!=null?Visibility(
                visible: picked && typefile,
                child: Expanded(
                    child: Container(
                      child:Container(
                          height: sh*0.8,
                          width: sw,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(onPressed: (){
                                    setState(() {
                                      picked=false;
                                      typefile=false;
                                      typeImage=false;
                                    });
                                  }, icon: Icon(
                                    Icons.cancel_outlined,color: Colors.black,
                                    size: 50,
                                  )),
                                  SizedBox(width: 20,),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.grey
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black
                                      ),
                                      child: Center(child: Text('${extention}',style: TextStyle(color: Colors.white),)),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('${Filename}',style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    )),
              ):Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(sh),border: Border.all(width: 1,color: Colors.grey)),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchTextFields(
                          height: 50,
                          hintText: "Type a message",
                          controller: messageBodyController,
                          prefixIcon:  Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: ()async{
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(type:FileType.image,allowMultiple: false);
                                    if(result != null) {
                                      file = result.files.single.path;
                                      print(file);
                                      name= result.files.single.name;
                                      // FirebaseStorage storage = FirebaseStorage.instance;
                                      // Reference ref = storage.ref().child('messages').child(name!);
                                      // await ref.putFile(File(file!));
                                      // imageUrl = await ref.getDownloadURL();
                                      // setState(() {
                                      //   print(imageUrl);
                                      // });
                                      setState(() {
                                        if(result.files.single.extension=='jpg' || result.files.single.extension=='png' || result.files.single.extension=='jpeg'){
                                          picked=true;
                                          typeImage=true;
                                          typefile=false;
                                          extention=result.files.single.extension;
                                          Filename=result.files.single.name;
                                        }
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  },

                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: ()async{
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
                                    if(result != null) {
                                      file = result.files.single.path;
                                      print(file);
                                      name= result.files.single.name;
                                      setState(() {
                                        if(result.files.single.extension=='jpg' || result.files.single.extension=='png' || result.files.single.extension=='jpeg'){
                                          picked=true;
                                          typeImage=true;
                                          extention=result.files.single.extension;
                                          Filename=result.files.single.name;
                                        }
                                        if(result.files.single.extension=='doc' || result.files.single.extension=='pdf' || result.files.single.extension=='txt' || result.files.single.extension=='docx' || result.files.single.extension=='xlsx' ){
                                          picked=true;
                                          typefile=true;
                                          typeImage=false;
                                          extention=result.files.single.extension;
                                          Filename=result.files.single.name;
                                        }
                                      });
                                    } else {
                                      //   // User canceled the picker
                                    }
                                  },
                                  child: Icon(
                                    CupertinoIcons.paperclip,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           InkWell(
                            onTap: ()async{
                              if(file==null && messageBodyController.text.isNotEmpty){
                                setState(() {
                                  message_Model model=message_Model(
                                      createdAt: DateTime.now(),
                                      senderId: FirebaseAuth.instance.currentUser!.uid,
                                      messageBody:messageBodyController.text,
                                      fileUrl: imageUrl,
                                      messagetype: extention,
                                      recieverId: widget.recieverId
                                  );
                                  chatService_controller().createMessage(model);
                                  messageBodyController.clear();
                                });
                              }else{
                                FirebaseStorage storage = FirebaseStorage.instance;
                                Reference ref = storage.ref().child('messages').child(name);
                                setState(() {
                                  print(imageUrl);
                                });
                                await ref.putFile(File(file!)).then((p0) async => {
                                  imageUrl = await ref.getDownloadURL(),
                                  setState(() {
                                    message_Model model=message_Model(
                                        createdAt: DateTime.now(),
                                        senderId: FirebaseAuth.instance.currentUser!.uid,
                                        messageBody:messageBodyController.text,
                                        fileUrl: imageUrl,
                                        messagetype: extention,
                                        recieverId: widget.recieverId
                                    );
                                    chatService_controller().createMessage(model);
                                    messageBodyController.clear();
                                  })
                                });
                              }
                              setState(() {
                                picked=false;
                                typeImage=false;
                                typefile=false;
                              });
                              imageUrl=null;
                              extention=null;
                              file=null;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                CupertinoIcons.paperplane_fill,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
