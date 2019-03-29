import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/notification_data.dart';

import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/forms/signin_form.dart';
import 'package:life_moment/views/main_view.dart';

class GlobalState {

  // Stream snapshot
  static AsyncSnapshot<dynamic> authSnapshot;
  static AsyncSnapshot<dynamic> userProfileSnapshot;
  static AsyncSnapshot<dynamic> notificationSnapshot;

    // User Data state
  static FirebaseUser get firebaseUser {
    return authSnapshot.data;
  }

  static UserProfile get userProfile {

    Map<String, dynamic> dataMap = userProfileSnapshot.data.documents[0].data;
    dataMap['documentID'] = userProfileSnapshot.data.documents[0].documentID;
    return UserProfile.createFromDataMap(dataMap: dataMap);
  }

  static List<NotificationData> get notificationList {

    List<NotificationData> list = [];

    List<dynamic> notifications = notificationSnapshot.data.documents;
    notifications.forEach((n){
      Map<String, dynamic> dataMap = n.data;

      NotificationData data = NotificationData.createFromDataMap(dataMap);

      list.add(data);
    });
    
    return list;
  }

  static int get notificationCount {
    if (notificationSnapshot.hasData){
      return notificationSnapshot.data.documents.length;
    }
    return 0;
  }


  // User Data
  static bool previousUserDocumentNotFound = false;

  static Map<String, NewsFeedData> _tempNewsFeedDataMap = {};
  static Map<String, NewsFeedData> _newsFeedDataMap = {};
  static Map<String, NewsFeedData> _userPostDataMap = {};



  static bool isNewsFeedDataEmpty(){

    return _newsFeedDataMap.isEmpty && _tempNewsFeedDataMap.isEmpty;
  }

  static void updateNewsFeedDataList(NewsFeedData data){

    String postID = data.postID;
    if (_tempNewsFeedDataMap.containsKey(postID)){
      _tempNewsFeedDataMap.remove(postID);
    }
    _newsFeedDataMap[data.postID] = data;  
  }

  static void appendNewsFeedDataToTempList(NewsFeedData data){

    String postID = data.postID;
    _tempNewsFeedDataMap[postID] = data;
  }

  static void updateUserPostDataList(NewsFeedData data){
    String postID = data.postID;
    _userPostDataMap[postID] = data;
  }

  static void clearUserPostDataList(){
    _userPostDataMap.clear();
  }

  static List<NewsFeedData> get newsFeedDataList {
    return _newsFeedDataMap.values.toList();
  }

  static List<NewsFeedData> get newsFeedDataTempList {
    return _tempNewsFeedDataMap.values.toList();
  }

  static List<NewsFeedData> get userPostDataList {
    return _userPostDataMap.values.toList();
  }





  static List<MoodChartData> moodChartData = [];



  static Map<String, UserProfile> _searchResultMap = {};

  static void appendSearchResult(UserProfile profile){

    String uid = profile.uid;
    _searchResultMap[uid] = profile;
  }

  static List<UserProfile> get searchResultList {
    return _searchResultMap.values.toList();
  }

  static void clearSearchResult(){
    _searchResultMap.clear();
  }

  // static Stream<List<NewsFeedData>> newsFeedDataStream() async*{
    
  //   // for (int i=0; i<newsFeedDataList.length; i++){
  //   //   yield newsFeedDataList[i];
  //   // }
  //   yield newsFeedDataList;
  // }

  // System state
  

  static void clearCurrentState(){

    _newsFeedDataMap.clear();
    _tempNewsFeedDataMap.clear();
    _userPostDataMap.clear();
    _searchResultMap.clear();
  }


  static SignInForm signInForm;

  static void changeProfileTo(String uid){

    
  }
}


//   static Mood _currentMood = Mood.Normal;

//   static MainViewState mainViewState;

//   static void updateCurrentMood(Mood mood){
//     _currentMood = mood;
//     if (mainViewState != null){
//       mainViewState.updateMood(_currentMood);
//     }
//   }
// }


