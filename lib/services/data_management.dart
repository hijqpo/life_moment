import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class DataManagement {

  static Future<OperationResponse> submitNewPost(PostData data) async{

    try {

      String userDocumentID = GlobalState.userProfile.documentID;

      UserProfile profile = GlobalState.userProfile;
      DateTime currentDateTime = DateTime.now();

      await Firestore.instance.collection('users').document(userDocumentID).collection('posts').add({

        'uid': profile.uid,

        'moodType': data.mood.moodTypeCode,
        'moodIntensity': data.mood.intensity,

        'description': data.description,
        'postTime': currentDateTime
      });

      // Add a local copy of the post, so no refresh is required to show this new post
      GlobalState.newsFeedDataList.add(NewsFeedData(
        uid: profile.uid,
        nickname: profile.nickname,
        mood: data.mood,
        description: data.description,
        postTime: currentDateTime,
      ));
      return OperationResponse(20, false, 'Success');
    }
    catch(error){

      debugPrint(error.toString());
      return OperationResponse(103, true, error.toString());
    }
  }

  static Future<OperationResponse> loadNewsFeed() async{

    try{

      // String userDocumentID = GlobalState.userProfile.documentID;

      // Load all posts
      List<NewsFeedData> list = [];
      
      // // Method 1: 
      // CollectionReference usersRef = Firestore.instance.collection('users');

      // Query selfOnlyQuery = usersRef.where('uid', isEqualTo: GlobalState.userProfile.uid);

      // // QuerySnapshot usersSnapshot = await usersRef.getDocuments();
      // QuerySnapshot usersSnapshot = await selfOnlyQuery.getDocuments();

      // debugPrint('Number of users: ${usersSnapshot.documents.length}');

      
      // await Future.forEach(usersSnapshot.documents, (userDoc) async{

      //   debugPrint('Looking for ${userDoc.documentID} posts...');
      // //usersSnapshot.documents.forEach((userDoc) async{

      //   String instanceNickname = userDoc.data['nickname'];
      //   if (instanceNickname == null) instanceNickname = 'Anonymous';

      //   String instanceDocumentID = userDoc.documentID;
      //   QuerySnapshot instancePostsSnapshot = await usersRef.document(instanceDocumentID).collection('posts').getDocuments();

      //   instancePostsSnapshot.documents.forEach((doc){
        
          
      //     Mood instanceMood = Mood(
      //       typeCode: doc.data['moodType'],
      //       intensity: doc.data['moodIntensity']
      //     );

      //     NewsFeedData temp = NewsFeedData(
      //       nickname: instanceNickname,
      //       mood: instanceMood,
      //       description: doc.data['description'],
      //       postTime: doc.data['postTime']
      //     );
      //     list.add(temp);
      //   });
      // });

      // Method 2:
      // QuerySnapshot postsSnapshot = await Firestore.instance.collection('posts').getDocuments();
      // postsSnapshot.documents.forEach((doc) async {

      //   DocumentReference userRef = doc.data['userRef'];

      //   DocumentSnapshot docSnap = await userRef.get();
      //   String instanceNickname = docSnap.data['nickname'];

      //   debugPrint('instanceNickname: $instanceNickname');

      //   Mood instanceMood = Mood(
      //       typeCode: doc.data['moodType'],
      //       intensity: doc.data['intensity']
      //     );

      //     NewsFeedData temp = NewsFeedData(
      //       nickname: instanceNickname,
      //       mood: instanceMood,
      //       description: doc.data['description'],
      //       postTime: doc.data['postTime']
      //     );
      //     list.add(temp);
      // });


      
      

      // Method 3: Call From Cloud Function

      UserProfile userProfile = GlobalState.userProfile;

      var result = await CloudFunctions.instance.call(
        parameters: {
          'documentID': userProfile.documentID,
          'uid': userProfile.uid,
        }, 
        functionName: 'loadInterestedPosts');
      
      result.forEach((data) {

        Timestamp instanceTimestamp = Timestamp(data['postTime']['_seconds'], data['postTime']['_nanoseconds']);
        DateTime postTime = instanceTimestamp.toDate();

        Mood instanceMood = Mood(
          typeCode: data['moodType'],
          intensity: data['moodIntensity']
        );

        NewsFeedData temp = NewsFeedData(
          uid: data['uid'],
          nickname: data['nickname'],
          mood: instanceMood,
          description: data['description'],
          //postTime: data['postTime']
          noticed: data['selfNoticed'],
          noticeCount: data['noticeCount'],

          postTime: postTime,
          documentID: data['documentID'],
          ownerDocumentID: data['ownerDocumentID']
        );
        list.add(temp);
      });

      debugPrint('${result.toString()}');
      GlobalState.newsFeedDataList = list;
      debugPrint(list.toString());

      debugPrint('Send response');
      return OperationResponse(20, false, 'Success');
      // return OperationResponse(20, false, 'Success');
    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(103, true, error.toString());
    }
  }

  static Future<OperationResponse> searchUser({String keyword}) async{

    try {




    }
    catch(error){
      debugPrint(error.toString());
      return OperationResponse(103, true, error.toString());
    }
  }
}