import 'package:GetSetChat/helpers/helperfunctions.dart';
import 'package:GetSetChat/views/chatRoomScreen.dart';
import 'package:GetSetChat/views/search.dart';
import 'package:GetSetChat/views/signin.dart';
import 'package:GetSetChat/views/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    return await HelperFunction.getUserLoggedIn().then((value){
      setState(() {
        isUserLoggedIn = value;
      });     
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ChatRoom.routeName : (ctx) => ChatRoom(),
        SignIn.routeName : (ctx) => SignIn(),
        SignUp.routeName : (ctx) => SignUp(),
        Search.routeName : (ctx) => Search(),
        //ConversationScreen.routeName : (ctx) => ConversationScreen(),
      },
      home: isUserLoggedIn ? ChatRoom() : SignIn(),
    );
  }
}
