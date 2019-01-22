import 'package:flutter/material.dart';
import 'package:life_moment/forms/login_form.dart';
import 'package:life_moment/views/debug_setting_view.dart';

class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginViewState();
  }
}



class _LoginViewState extends State<LoginView> {

  _onSettingPressed() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DebugSettingView())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _onSettingPressed,
          )
        ]
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


