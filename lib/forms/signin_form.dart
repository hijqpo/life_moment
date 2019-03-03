import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/auth_management.dart';

import 'package:life_moment/views/signup_view.dart';



class SignInForm extends StatefulWidget {

  static _SignInFormState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_SignInFormState>());

  @override
  State<StatefulWidget> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {

  String _email, _password;

  String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  // This field use for locking any user input while the form is sent
  bool _loading = false;


  void setFormFieldWithValue({String email = '', String password = ''}){

    _emailFieldController.text = email;
    _passwordFieldController.text = password;
  }

  Future<void> onSignInPressed() async{

    debugPrint('Login is pressed');

    if (_formKey.currentState.validate()){

      debugPrint('[Login Form] Local form field check passed');
      _formKey.currentState.save();
      
      setState(() {
        _loading = true;
      });
      
      OperationResponse response = await AuthManagement.signIn(email: _email, password: _password);

      // If the response is error, show the error message
      if (response.isError){
        setState((){
          this._errorMessage = response.message;
          _loading = false;
        });
      }
      
      
    }
  }

  void onSignUpPressed(){

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

            // Email field
            TextFormField(
              controller: _emailFieldController,
              onSaved: (text) => _email = text,
              enabled: !_loading,
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
              validator: (value) {
                
                if (value.isEmpty){
                  return 'Please fill in this field';
                }
              },
              obscureText: true,
            ),

            // Error message
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.redAccent, fontSize: 14.0, height: 1),
              ),  
            ),
            

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                RaisedButton(
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                  color: Colors.lightBlue,                  
                  onPressed: _loading ? null : onSignInPressed,
                ),

                
              ],

            ),

            Divider(height: 50,),


            FlatButton(
                  child: Text(
                    'Don\'t have an account? Sign up now!',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  onPressed: () => onSignUpPressed(),
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
    super.dispose();
  } 

}


