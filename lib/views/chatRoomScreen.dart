import 'package:GetSetChat/services/auth.dart';
import 'package:GetSetChat/views/search.dart';
import 'package:GetSetChat/views/signin.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  static const routeName = '/chatRoom';
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = new AuthMethods();
    exit(){
      authMethods.signOut();
      Navigator.of(context).pushReplacementNamed(SignIn.routeName);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Set Chat'),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              exit();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.of(context).pushNamed(Search.routeName);
        },
      ),
    );
  }
}