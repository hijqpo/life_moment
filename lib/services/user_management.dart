import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

// Firebase package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// System
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class UserManagement {

  static Future<OperationResponse> search({@required String keyword}) async{

    try {

      UserProfile userProfile = GlobalState.userProfile;

      debugPrint('Searching with [$keyword]...');
      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'search', 
        parameters: {
        'uid': userProfile.uid,
        'keyword': keyword,
      });

      debugPrint('${result.last}');

      List<dynamic> searchResutls = result.first;

      searchResutls.forEach((data) {
        
        UserProfile profile = UserProfile.createFormDataMap(dataMap: data);

        GlobalState.appendSearchResult(profile);
      });

      return OperationResponse(20, false, 'Success');
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(104, true, error.toString());
    }
  }

  static Future<OperationResponse> sendFriendRequest({@required UserProfile receiverUserProfile}) async{

    try{

      UserProfile senderUserProfile = GlobalState.userProfile;

      // debugPrint('Prepare to send friend request to ${receiverUserProfile.uid}, documentID: ${receiverUserProfile.documentID}');

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'sendFriendRequest',
        parameters: {
          'senderUID': senderUserProfile.uid,
          //'senderDocumentID': senderUserProfile.documentID,
          'receiverUID': receiverUserProfile.uid,
          //'receiverDocumentID': receiverUserProfile.documentID,
        }
      );

      debugPrint('${result.last}');
      return OperationResponse(20, false, 'Success');
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(104, true, error.toString());
    }

  }
}



