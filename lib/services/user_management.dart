import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

// Firebase package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';

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
        
        UserProfile profile = UserProfile.createFromDataMap(dataMap: data);

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

  static Future<OperationResponse> updateUserProfile({String nickname, File avatarFile}) async{

    try{

      UserProfile profile = GlobalState.userProfile;

      var newAvatarURL;

      if (avatarFile != null){
        StorageReference avatarRef = FirebaseStorage.instance.ref().child('user_avatars').child('${profile.uid}.png');

        StorageMetadata metadata = StorageMetadata(contentType: 'image/png');
        StorageTaskSnapshot uploadSnapshot = await avatarRef.putFile(avatarFile, metadata).onComplete;
        newAvatarURL = await uploadSnapshot.ref.getDownloadURL();
        debugPrint('[UpdateUserProfile] New Avatar URL: $newAvatarURL');
      }

      List<dynamic> result = await CloudFunctions.instance.call(
        functionName: 'updateUserProfile',
        parameters: {
          'uid': profile.uid,
          'oldNickname': profile.nickname,
          'oldAvatarURL': profile.avatarURL,
          'newNickname': nickname,
          'newAvatarURL': newAvatarURL,
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

  static Future<OperationResponse> loadUserPostsAndMoods({@required String uid}) async{

    try {

      List<dynamic> postResult = await CloudFunctions.instance.call(
        functionName: 'loadUserPosts',
        parameters: {
          'uid': uid
        }
      );
      debugPrint('${postResult.last}');
      List<dynamic> posts = postResult.first;

      posts.forEach((p){

        NewsFeedData instanceData = NewsFeedData.createFromDataMap(dataMap: p);
        GlobalState.updateUserPostDataList(instanceData);
      });


      List<dynamic> moodResult = await CloudFunctions.instance.call(
        functionName: 'loadUserMoods',
        parameters: {
          'uid': uid
        }
      );
      debugPrint('${moodResult.last}');
      List<dynamic> moods = moodResult.first;

      List<MoodChartData> moodList = [];
      moods.forEach((m){

        MoodChartData instanceData = MoodChartData(m['time'], m['moodType'], m['moodIntensity']);
        moodList.add(instanceData);
      });
      GlobalState.moodChartData = moodList;

      return OperationResponse(20, false, 'Success');
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(104, true, error.toString());
    }
  }

  static Future<OperationResponse> loadUserMood(String uid) async{

    try {
      List<dynamic> moodResult = await CloudFunctions.instance.call(
          functionName: 'loadUserMoods',
          parameters: {
            'uid': uid
          }
        );
        debugPrint('${moodResult.last}');
        List<dynamic> moods = moodResult.first;

        List<MoodChartData> moodList = [];
        moods.forEach((m){

          DateTime instanceDateTime = Timestamp(m['time']['_seconds'], m['time']['_nanoseconds']).toDate();

          MoodChartData instanceData = MoodChartData(instanceDateTime, m['moodType'], m['moodIntensity']);
          moodList.add(instanceData);
        });

        return OperationResponse(20, false, 'Success', data: moodList);
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(104, true, error.toString());
    }
  }

}



