import 'package:flutter/material.dart';
import 'package:life_moment/forms/signin_form.dart';
import 'package:life_moment/views/debug_setting_view.dart';

class SignInView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _SignInViewState();
  }
}



class _SignInViewState extends State<SignInView> {

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
              child: SignInForm(),
              
              )
          ]
        ),
      )
    );
  }


}


