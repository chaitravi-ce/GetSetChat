import 'package:GetSetChat/helpers/constants.dart';
import 'package:GetSetChat/services/database.dart';
import 'package:GetSetChat/views/conversationScreen.dart';
import 'package:GetSetChat/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static const routeName = '/search';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController usernameSearch = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;
  initiateSearch(){
    databaseMethods.getUserByUsername(usernameSearch.text).then((val){
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot.documents.length,
      itemBuilder: (ctx,i)=> SearchTile(searchSnapshot.documents[i].data['username'],searchSnapshot.documents[i].data['email'])
    ) : Container();
  }

  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Row(children: <Widget>[
              Expanded(
                child: TextField(
                  controller: usernameSearch,
                  decoration: InputDecoration(
                    hintText: 'Search Username',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none
                  ),
                ),
              ),
              GestureDetector(
                child: Icon(Icons.search, color: Colors.white,),
                onTap: (){
                  initiateSearch();
                },
              )
            ],),
          ),
          searchList()
        ],),
      )
    );
  }
}

getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}

createChatRoomAndStartConversation(BuildContext context, String username){
  print('==================================');
  print(Constants.myName);
  String chatRoomId = getChatRoomId(username, Constants.myName);
  List<String> users = [username, Constants.myName];
  Map<String, dynamic> chatRoomMap = {
    "users" : users,
    "chatRoomId" : chatRoomId
  };
  DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
  Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
}


class SearchTile extends StatelessWidget {
  final String username;
  final String email;

  SearchTile(this.username,this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text(username, style: simpleText(),),
          Text(email, style: simpleText(),),
        ],),
        Spacer(),
        GestureDetector(
          onTap: (){
            createChatRoomAndStartConversation(context, username);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Text('Message', style: simpleText(),),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        )
      ],),
    );
  }
}