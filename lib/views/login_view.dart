import 'package:flutter/material.dart';
import 'package:life_moment/forms/login_form.dart';

class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginViewState();
  }
}



class _LoginViewState extends State<LoginView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Login'),

      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: LoginForm(),
              
              )
          ]
        ),
      )
    );
  }


}


