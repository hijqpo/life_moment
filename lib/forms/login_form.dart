import 'package:flutter/material.dart';
import 'package:life_moment/views/signup_view.dart';
import 'package:life_moment/views/main_view.dart';

class LoginForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginFormState();
  }
}



class _LoginFormState extends State<LoginForm> {


  final _formKey = GlobalKey<FormState>();
  final _loginIdFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();



  _onLoginPressed() {

    debugPrint('Login is pressed');
    if (_formKey.currentState.validate()){
      debugPrint('[Login Form] Local form field check passed');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView())
      );
    }
  }

  _onSignUpPressed(){

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SignUpView())
    );
  }


  @override
  Widget build(BuildContext context) {

    return

      Form(
        key: _formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Login field
            TextFormField(
              controller: _loginIdFieldController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Login ID',

              ),

              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            // Password field
            TextFormField(
              // Password field
              controller: _passwordFieldController,
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: 'Password',

              ),
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              },
              obscureText: true,
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                RaisedButton(
                  child: Text('Login'),
                  onPressed: () => _onLoginPressed(),
                ),

                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: () => _onSignUpPressed(),
                )
              ],

            ),



          ]
      )
      



    );
  }

  @override
  void dispose(){

    // Clean up the text edit controller here:
    _loginIdFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  } 

}


