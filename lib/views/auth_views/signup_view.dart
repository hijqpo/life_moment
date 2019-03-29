import 'package:flutter/material.dart';
import 'package:life_moment/forms/signup_form.dart';

class SignUpView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _SignUpViewState();
  }
}



class _SignUpViewState extends State<SignUpView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: SignUpForm(),
              
              )
          ]
        ),
      )
    );
  }


}


