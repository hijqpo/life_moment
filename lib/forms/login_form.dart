import 'package:flutter/material.dart';
import 'package:life_moment/views/signup_view.dart';
import 'package:life_moment/views/main_view.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {

  static _LoginFormState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_LoginFormState>());

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}



class _LoginFormState extends State<LoginForm> {

  String _email, _password;

  String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();


  void setFormFieldWithValue({String email = '', String password = ''}){

    _emailFieldController.text = email;
    _passwordFieldController.text = password;
  }




  Future<void> _onLoginPressed() async{

    debugPrint('Login is pressed');


    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
      debugPrint('[Login Form] Local form field check passed');

      
      try {
        debugPrint('[Login Form] Attempt to login to Firebase');
        _onStartLoading();
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        

        debugPrint(user.toString());

        
        _onFinishLoading();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainView())
        );
      }
      catch (error){
        setState(() {
          if (error.code == 'sign_in_failed'){
            this._errorMessage = 'Incorrect Email / Password';
          }
          else {
            this._errorMessage = 'Unknown error - Error Code: ${error.code}';
          }          
        });
        print(error.toString());
        _onFinishLoading();
      }

    }
  }

  void _onSignUpPressed(){

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SignUpView())
    );
  }

  void _onStartLoading(){
    
    showDialog(

      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Loading...', style: TextStyle(fontWeight: FontWeight.w500),),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            )
            
          ],
        );
      }
    );
  }

  void _onFinishLoading(){
     Navigator.pop(context);
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
                  child: Text('Login'),
                  onPressed: () => _onLoginPressed(),
                ),

                
              ],

            ),

            Divider(height: 50,),


            FlatButton(
                  child: Text(
                    'Don\'t have an account? Sign up now!',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  onPressed: () => _onSignUpPressed(),
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


