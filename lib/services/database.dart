import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username)async{
    return await Firestore.instance.collection("users").where("username",isEqualTo : username).getDocuments();
  }

  getUserByEmail(String email)async{
    return await Firestore.instance.collection("users").where("email",isEqualTo : email).getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection('users').add(userMap).catchError((e){
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection('chatRoom').document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap){
    Firestore.instance.collection("chatRoom").document(chatRoomId).collection("chats").add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId)async{
    // ignore: await_only_futures
    return await Firestore.instance.collection("chatRoom").document(chatRoomId).collection("chats").orderBy("time", descending: false).snapshots();
  }

  getChatRooms(String username){
    return Firestore.instance.collection("chatRoom").where("users", arrayContains: username).snapshots();
  }
}