import 'package:flutter/material.dart';

// Firebase package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// System
import 'package:life_moment/state.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/views/app_views/dashboard/dashboard.dart';
import 'package:life_moment/views/auth_views/signin_view.dart';

// Views
// import 'package:life_moment/views/dashboard.dart';
//import 'package:life_moment/views/signin_view.dart';

class StreamWidget {

    static Widget streamStructure(){

    return StreamBuilder(
      
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, authSnapshot){

        // Let the snapshot can be access gloabally
        GlobalState.authSnapshot = authSnapshot;

        // Show loading screen
        if (authSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }

        // If current
        if (authSnapshot.hasData){

          // Reference of the firebase user
          // GlobalState.cfirebaseUser = authSnapshot.data;
          

          // User Profile Stream:
          // This read the 'users' document in Firestore
          return StreamBuilder( 

            stream: Firestore.instance.collection('users').where('uid', isEqualTo: authSnapshot.data.uid).snapshots(),
            builder: (BuildContext context, userProfileSnapshot){

              // Let the snapshot can be access gloabally
              GlobalState.userProfileSnapshot = userProfileSnapshot; 
              
              if (userProfileSnapshot.hasError){
                return Center(child: Text('User Data Module Error :('));
              }

              if (userProfileSnapshot.hasData){

                if (userProfileSnapshot.data.documents.length == 0){
                  // return Center(child: Text('User Profile not Found'));
                  return SignInView();
                }
                debugPrint(GlobalState.userProfileSnapshot.data.documents[0].data.toString());
                return Dashboard();
              }


              return CircularProgressIndicator();

            }
          );
        }
                
        return SignInView();
      }
    );
  }
}