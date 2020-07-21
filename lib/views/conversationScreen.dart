import 'package:GetSetChat/helpers/constants.dart';
import 'package:GetSetChat/services/database.dart';
import 'package:GetSetChat/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  static const routeName = '/convScreen';
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  TextEditingController messageController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream<QuerySnapshot> chats;

  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(
              snapshot.data.documents[index].data["message"], 
              snapshot.data.documents[index].data["sentBy"] == Constants.myName ? true : false,               
            );
          }
        ) : Container();
      },
    );
  }


  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageController.text,
        "sentBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);  
      messageController.text = "";
    }
    
  }

  @override
  void initState() {
    print('=================================');
    DatabaseMethods().getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        print('=============================');
        print(value);
        chats = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),                   
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.send, color: Colors.white,)
                    ),
                    onTap: (){
                      print('==============================');
                      sendMessage();
                    },
                  )
                ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {

  final String message;
  final bool isSentByMe;
  MessageTile(this.message,this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isSentByMe ? 0 : 24,
        right: isSentByMe ? 24 : 0
      ),
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSentByMe
          ? EdgeInsets.only(left: 30)
          : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: isSentByMe ? BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23)
          ) : 
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23)
          ),
          gradient: LinearGradient(
            colors: isSentByMe ? 
            [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ]
          : [
              const Color(0x1AFFFFFF),
              const Color(0x1AFFFFFF)
              ],
            )
          ),
          child: Text(
            message, 
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),),
      ),
    );
  }
}