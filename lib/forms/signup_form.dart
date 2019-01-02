import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _SignUpFormState();
  }
}



class _SignUpFormState extends State<SignUpForm> {


  final _formKey = GlobalKey<FormState>();
  final _loginIdFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _nicknameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();


  _onSignUpPress() {

    debugPrint('Sign Up is pressed');
    if (_formKey.currentState.validate()){
      debugPrint('[Login Form] Local form field check passed');
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
                icon: Icon(Icons.person),
                labelText: 'Password',

              ),
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            TextFormField(
              // Password field
              controller: _nicknameFieldController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Nickname',

              ),
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            TextFormField(
              // Password field
              controller: _emailFieldController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Email',

              ),
              validator: (value) {

                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              }
            ),

            RaisedButton(
              
              child: Text('Sign Up'),
              onPressed: () => _onSignUpPress(),

            )
          ]
      )
    );
  }

  @override
  void dispose(){

    // Clean up the text edit controller here:


    super.dispose();
  } 

}


