import 'package:flutter/material.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';

class ProfileView extends StatefulWidget {

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  String _uid;

  @override
  Widget build(BuildContext context) {

    if (_uid == ''){
      // show self profile 
    }
    else{
      // show others profile
      
    }


    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(GlobalState.userProfile.nickname),
          FlatButton(

            onPressed: UserManagement.signOut,
            child: Text('Sign Out'),
            color: Colors.red[100],
          )
        ]  
      ),
    );
  }
}