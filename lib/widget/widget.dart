import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Text('Get Set Chat', style: TextStyle(fontStyle: FontStyle.italic)),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
  );
}

TextStyle simpleText(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16,              
  );
}
