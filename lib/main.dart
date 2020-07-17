import 'package:GetSetChat/views/chatRoomScreen.dart';
import 'package:GetSetChat/views/search.dart';
import 'package:GetSetChat/views/signin.dart';
import 'package:GetSetChat/views/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChatRoomScreen.routeName : (ctx) => ChatRoomScreen(),
        SignIn.routeName : (ctx) => SignIn(),
        SignUp.routeName : (ctx) => SignUp(),
        Search.routeName : (ctx) => Search(),
      },
      home: SignUp(),
    );
  }
}
