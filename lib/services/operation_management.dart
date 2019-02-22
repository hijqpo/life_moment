import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class OperationManagement {

  /// Mark the post as Noticed or unmark it if it is already noticed
  /// 
  /// [postDocumentID]: The document ID of the of the post, can be retrive in NewsFeedData
  /// 
  static Future<OperationResponse> noticePost({@required postDocumentID, @required postOwnerDocumentID}) async {

    String uid = GlobalState.userProfile.uid;

    try{

      debugPrint('Noticing the following post: \n -- Post Document ID: $postDocumentID\n -- Post Owner Document ID: $postOwnerDocumentID\n -- UID: $uid ');
      await CloudFunctions.instance.call(functionName: 'noticePost', parameters: {

        'uid': uid,
        'postDocumentID': postDocumentID,
        'postOwnerDocumentID': postOwnerDocumentID
      });

      return OperationResponse(20, false, 'Success');

    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(104, true, error.toString());
    }
  }




}