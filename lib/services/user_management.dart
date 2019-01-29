import 'package:flutter/material.dart';

// Firebase package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_moment/state.dart';

// Views
import 'package:life_moment/views/dashboard.dart';
import 'package:life_moment/views/login_view.dart';

class UserManagement {

  static Widget authModule(){

    return StreamBuilder(
      
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {

        // Show loading screen
        if (snapshot.connectionState == ConnectionState.waiting){
          return Text('Loading');
        }

        // If current
        if (snapshot.hasData){
          GlobalState.currentUser = snapshot.data;
          return Dashboard();
        }
        
        return LoginView();
      }
    );
  }

  static void signOut(){
    FirebaseAuth.instance.signOut();
  }

  static Widget userProfile(){

    return StreamBuilder(
      
      stream: Firestore.instance.collection('users').where('uid', isEqualTo: GlobalState.currentUser.uid).snapshots(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError){
          return Center(child: Text('Error :('));
        }

        if (snapshot.hasData){

          if (snapshot.data.documents.length == 0){
            return Center(child: Text('User data not found'));
          }

          DocumentSnapshot documentSnapshot = snapshot.data.documents[0];

          return Container(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Display Name: ${documentSnapshot.data['displayName']}')      
                  ],
                ),
              ),
          );
          
        }

        return Center(child: Text('Nothing Here'));
      }
    );
  }


}



