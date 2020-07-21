import 'package:GetSetChat/helpers/constants.dart';
import 'package:GetSetChat/helpers/helperfunctions.dart';
import 'package:GetSetChat/services/auth.dart';
import 'package:GetSetChat/services/database.dart';
import 'package:GetSetChat/views/conversationScreen.dart';
import 'package:GetSetChat/views/search.dart';
import 'package:GetSetChat/views/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/chat';
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ChatRoomsTile(
              userName: snapshot.data.documents[index].data['chatRoomId'].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
              chatRoomId: snapshot.data.documents[index].data["chatRoomId"],
            );
          })
        : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunction.getUserName();
    //DatabaseMethods().getChatRooms(Constants.myName).then((snapshots) {
    //  setState(() {
    //    chatRooms = snapshots;
    //    print("we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
    //  });
    //});
    chatRooms = Firestore.instance.collection("chatRoom").where("users", arrayContains: Constants.myName).snapshots();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Set Chat'),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              AuthMethods().signOut();
              Navigator.of(context).pushReplacementNamed(SignIn.routeName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app)
            ),
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).pushNamed(Search.routeName);
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId,
          )
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300
                )
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300
              )
            )
          ],
        ),
      ),
    );
  }
}