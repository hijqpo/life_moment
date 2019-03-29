import 'package:flutter/material.dart';
import 'package:life_moment/services/auth_management.dart';

class ErrorView extends StatelessWidget {

  ErrorView({this.errorMessage = ''});

  final String errorMessage;

  void _onSignOutPressed(){
    AuthManagement.signOut();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[

            Text(
              '$errorMessage',
              style: TextStyle(
                color: Colors.red
              )
              
            ),

            RaisedButton(
              onPressed: _onSignOutPressed,
              child: Text(
                'Return To Sign In'
              ),
            )

          ],
        ),
      )
    );
  }
}