import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/message_Model.dart';

class chatService_controller{
  StreamController<List<message_Model>> chatController=StreamController<List<message_Model>>.broadcast();
  Future createMessage(message_Model model)async{
    try{
      await FirebaseFirestore.instance.collection('messages').doc('${DateTime.now().toString()}').set(
        model.toJson()
      );
      await FirebaseFirestore.instance.collection('chats').doc(FirebaseAuth.instance.currentUser!.uid).collection('users').doc(model.recieverId).set(
            model.toJson()
          );
      await FirebaseFirestore.instance.collection('chats').doc(model.recieverId).collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
          model.toJson()
      );
      }catch(ex){
    }
  }

  Stream<List<message_Model>>? GetRealTimeMessage(var othersId){
    try{
      var messageQuerySnapshot=FirebaseFirestore.instance.collection('messages').snapshots().listen((messageEvent) {
        if(messageEvent.docs.isNotEmpty){
          var message=messageEvent.docs.map((item) =>
           message_Model.fromJson(item.data())).where((element) => (element.recieverId==othersId && element.senderId==FirebaseAuth.instance.currentUser!.uid)||(element.recieverId==FirebaseAuth.instance.currentUser!.uid && element.senderId==othersId)).toList().reversed.toList();
        chatController.add(message);
        }
      });
      return chatController.stream;
  }catch(ex){
      return null;
    }
    }
}