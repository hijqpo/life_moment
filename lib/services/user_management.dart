import 'dart:async';

import 'package:flutter/material.dart';

// Firebase package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// System
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class UserManagement {

  static Future<OperationResponse> signIn({email, password}) async{

    try {

        debugPrint('[Auth] Attempt to login to Firebase');

        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        debugPrint('[Auth] Login Success ${user.toString()}');

        OperationResponse response = await initialUserDocument(user);

        if (response.code == 51){
          GlobalState.previousUserDocumentNotFound = true;
        }
        return response;
      }
      catch (error){

        debugPrint('[Auth] Login Fail');
        debugPrint(error.toString());

        if (error.code == 'sign_in_failed'){
          // Sign fail, probably incorrect email or password
          return OperationResponse(101, true, 'Incorrect Email / Password');
        }
        else {
          // Unknown error
          return OperationResponse(100, true, 'Unknown error - Error Code: ${error.code}');
        }          
      }
  }

  static void signOut(){
    // TODO: Clear current user session related state
    GlobalState.previousUserDocumentNotFound = false;

    FirebaseAuth.instance.signOut();
  }

  static Future<OperationResponse> signUp({@required email, @required password, String nickname}) async{

    try {

      debugPrint('[Auth] Attempt to create user');

      FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      debugPrint('[Auth] Create Success');

      OperationResponse response = await initialUserDocument(user, nickname: nickname);
      return response;
    } 
    catch (error) {

      debugPrint('[Auth] Create User Fail');
      debugPrint(error.toString());

      if (error.code == 'sign_in_failed'){
        // TODO: Can be improved
        return OperationResponse(102, true, error.details);
      }
      else{
        // Unknown error
        return OperationResponse(100, true, error.toString());
      }
    }
  }

  static Future<OperationResponse> initialUserDocument(FirebaseUser user, {String nickname}) async{

    try{

      Query query = Firestore.instance.collection('users').where('uid', isEqualTo: user.uid);
      QuerySnapshot snapshot = await query.getDocuments();

      if (snapshot.documents.length > 0){
        // Document found, no need to do initialization
        return OperationResponse.ok;
      }
      else{
        // Document not found, create one instead
        await Firestore.instance.collection('users').add({
          'uid': user.uid,
          'email': user.email,
          'nickname': nickname == null ? 'Anonymous' : nickname
        });
        debugPrint('[User Data] New User document is created');
        return OperationResponse(51, false, 'OK');
      }
    }
    catch (error){

      debugPrint('[User Data] Error occur during initialing user document');
      return OperationResponse(105, true, 'Operation Error');
    }
  }
}



