import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/forms/signin_form.dart';
import 'package:life_moment/views/main_view.dart';


enum Mood {
  VeryHappy,
  Happy,
  Normal,
  VerySad,
  Sad,
}


class GlobalState {


  // Stream snapshot
  static AsyncSnapshot<dynamic> authSnapshot;
  static AsyncSnapshot<dynamic> userProfileSnapshot;

    // User Data state
  static FirebaseUser get firebaseUser {
    return authSnapshot.data;
  }

  static DocumentSnapshot get userProfile {
    return userProfileSnapshot.data.documents[0];
  }




  // User Data
  static bool previousUserDocumentNotFound = false;

  // System state
  

  static SignInForm signInForm;




  static Mood _currentMood = Mood.Normal;

  static MainViewState mainViewState;

  static void updateCurrentMood(Mood mood){
    _currentMood = mood;
    if (mainViewState != null){
      mainViewState.updateMood(_currentMood);
    }
  }
}





