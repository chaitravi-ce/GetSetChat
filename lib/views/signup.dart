import 'package:GetSetChat/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              SizedBox(height: 200,),
              TextField(
                decoration: textFieldInputDecoration('username'),
                style: simpleText(),
                controller: username,
              ),
              TextField(
                decoration: textFieldInputDecoration('email'),
                style: simpleText(),
                controller: email,
              ),
              TextField(
                decoration: textFieldInputDecoration('password'),
                style: simpleText(),
                controller: password,
              ),
              SizedBox(height: 16,),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: Text('Sign Up', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),),
              ),
              SizedBox(height: 16,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: Text('Sign In with Google', style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Already Have an Account ?", style: simpleText(),),
                SizedBox(width: 4,),
                Text("Sign In", 
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],)
            ],),
          ),
        ),
      )
    );
  }
}