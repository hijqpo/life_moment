import 'package:flutter/material.dart';
import 'package:life_moment/forms/login_form.dart';

class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginViewState();
  }
}



class _LoginViewState extends State<LoginView> {


  _onLoginPress() {

    debugPrint('Login is pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginForm(),
          ]
        ),
      )
    );
  }


}


