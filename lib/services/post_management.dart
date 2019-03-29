import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class PostManagement {

  static Future<OperationResponse> createNewPost(PostData data) async{

    try {

      UserProfile profile = GlobalState.userProfile;
      data.postID = '${profile.uid}--p${profile.postCount}';

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'createNewPost',
        parameters: {
          'uid': profile.uid,
          'documentID': profile.documentID,
          'postID': data.postID,
          'moodType': data.mood.moodTypeCode,
          'moodIntensity': data.mood.intensity,
          'description': data.description,
        }
      );

      debugPrint('${result.last}');      

      // Add a local copy of the post, so no refresh is required to show this new post

      NewsFeedData instanceNewsFeedDate = NewsFeedData.createFromPostData(data: data);
      GlobalState.appendNewsFeedDataToTempList(instanceNewsFeedDate);

      return OperationResponse(20, false, 'Success');
    }
    catch(error){

      debugPrint('Received error: ${error.message}');
      return OperationResponse(103, true, error.message);
    }
  }

  static Future<OperationResponse> loadNewsFeed() async{

    try{
      // Load all posts

      UserProfile userProfile = GlobalState.userProfile;

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'loadInterestedPosts',
        parameters: {
          'uid': userProfile.uid,
        }, 
      );

      // Last element of result is operation messages
      debugPrint(result.last);
      
      // // Fetch the post data from result
      List<dynamic> postData = result.first;

      postData.forEach((data) {
        
        NewsFeedData instanceNewsFeedData = NewsFeedData.createFromDataMap(dataMap: data);

        GlobalState.updateNewsFeedDataList(instanceNewsFeedData);
      });

      return OperationResponse(20, false, 'Success', data: result.first);
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(103, true, error.toString());
    }
  }

  static Future<OperationResponse> supportPost(UserProfile userProfile, {@required String postDocumentID}) async {

    String uid = userProfile.uid;

    try{

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'supportPost', 
        parameters: {
          'uid': uid,
          'postDocumentID': postDocumentID,
      });

      debugPrint('${result.last}');
      return OperationResponse(20, false, 'Success');

    }
    catch(error){
      debugPrint(error.message);
      return OperationResponse(104, true, error.toString());
    }
  }

  static Future<OperationResponse> commentPost(String uid, String comment, String postDocumentID) async{

    try {

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'commentPost',
        parameters: {
          'uid': uid,
          'comment': comment,
          'postDocumentID': postDocumentID,
        }
      );

      debugPrint('${result.last}');
      return OperationResponse(20, false, 'Success');
    }
    catch(error){
      debugPrint(error.message);
      return OperationResponse(104, true, error.toString());
    }

  }


}