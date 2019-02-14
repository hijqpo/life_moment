import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/user_management.dart';

class SignUpForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _SignUpFormState();
  }
}



class _SignUpFormState extends State<SignUpForm> {


  final _formKey = GlobalKey<FormState>();

  final _passwordFieldController = TextEditingController();
  final _passwordConfirmFieldController = TextEditingController();
  final _nicknameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();

  String _errorMessage = '';
  String _email, _password, _nickname;

  bool _loading = false;

  Future<void> onSignUpPressed() async{

    debugPrint('Sign Up is pressed');
    if (_formKey.currentState.validate()){
      debugPrint('[Login Form] Local form field check passed');
      _formKey.currentState.save();

      _loading = true;
      OperationResponse response = await UserManagement.signUp(email: _email, password: _password, nickname: _nickname);

      if (response.isError){
        setState((){
          _errorMessage = response.message;
        });
      }
      else{
        setState(() {
          _errorMessage = '';
          Navigator.pop(context);
          
        });
      }

      _loading = false;
    }
  }



  @override
  Widget build(BuildContext context) {

    return

      Form(
        key: _formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(
              // Password field
              controller: _emailFieldController,
              onSaved: (text) => _email = text,
              enabled: !_loading,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',

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
              onSaved: (text) => _password = text,
              enabled: !_loading,
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: 'Password',

              ),
              obscureText: true,
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            TextFormField(
              // Password field
              controller: _passwordConfirmFieldController,
              enabled: !_loading,
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: 'Password Confirm',

              ),
              obscureText: true,
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }

                if (value != _passwordFieldController.text){
                  return 'Password not match';
                }
              }
            ),

            TextFormField(
              // Password field
              controller: _nicknameFieldController,
              onSaved: (text) => _nickname = text,
              enabled: !_loading,
              decoration: const InputDecoration(
                icon: Icon(Icons.face),
                labelText: 'Nickname',

              ),
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.redAccent, fontSize: 14.0, height: 1),
              ),  
            ),

            RaisedButton(
              
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              color: Colors.lightBlue,
              onPressed: _loading ? null : onSignUpPressed,

            )
          ]
      )
    );
  }

  @override
  void dispose(){

    // Clean up the text edit controller here:

    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _passwordConfirmFieldController.dispose();  
    _nicknameFieldController.dispose();

    super.dispose();
  } 

}


