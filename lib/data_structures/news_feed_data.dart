
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class NewsFeedData {

  static NewsFeedData createFromDataMap({Map<dynamic, dynamic> dataMap}){

    var uid = dataMap['uid'];
    if (uid == null || uid is! String){
      debugPrint('[NewsFeedData] Cannot read uid from the given dataMap, set to default value');
      uid = '';
    }

    var nickname = dataMap['nickname'];
    if (nickname == null || nickname is ! String){
      debugPrint('[NewsFeedData] Cannot read nickname from the given dataMap, set to default value [${UserProfile.defaultNickname}]');
      nickname = UserProfile.defaultNickname;
    }

    var postID = dataMap['postID'];
    if (postID == null || postID is! String){
      debugPrint('[NewsFeedData] Cannot read postID from the given dataMap, set to default value');
      postID = '';
    }

    var description = dataMap['description'];
    if (description == null || description is! String){
      debugPrint('[NewsFeedData] Cannot read description from the given dataMap, set to default value');
      description = '<No Description>';
    }

    var avatarURL = dataMap['avatarURL'];
    if (avatarURL == null || avatarURL is! String){
      debugPrint('[NewsFeedData] Cannot read avatarURL from the given dataMap, set to default value');
      avatarURL = UserProfile.defaultAvatarURL;
    }

    var moodTypeCode = dataMap['moodType'];
    var moodIntensity = dataMap['moodIntensity'];

    if (moodTypeCode == null || moodTypeCode is! int) moodTypeCode = -1;
    if (moodIntensity == null || moodIntensity is! int) moodIntensity = 0;

    Mood instanceMood = Mood(typeCode: moodTypeCode, intensity: moodIntensity);

    var timestampData = dataMap['postTime'];
    DateTime postTime;

    if (timestampData == null || timestampData is! Map<dynamic, dynamic>){
      debugPrint('[NewsFeedData] Cannot read postTime from the given dataMap, set to default value [DateTime.now]');
      postTime = DateTime.now();
    }
    else{
      postTime = Timestamp(timestampData['_seconds'], timestampData['_nanoseconds']).toDate();
    }

    var supported = dataMap['supported'];
    if (supported == null || supported is! bool){
      debugPrint('[NewsFeedData] Cannot read supported from the given dataMap, set to default value [false]');
      supported = false;
    }

    var supportCount = dataMap['supportCount'];
    if (supportCount == null || supportCount is! int){
      debugPrint('[NewsFeedData] Cannot read supportCount from the given dataMap, set to default value [0]');
      supportCount = 0;
    }

    var commentCount = dataMap['commentCount'];
    if (commentCount == null || commentCount is! int){
      debugPrint('[NewsFeedData] Cannot read commentCount from the given dataMap, set to default value [0]');
      commentCount = 0;
    }

    var postDocumentID = dataMap['postDocumentID'];
    if (postDocumentID == null || postDocumentID is! String){
      debugPrint('[NewsFeedData] Cannot read postDocumentID from the given dataMap, set to default value');
      postDocumentID = '';
    }

    var postOwnerDocumentID = dataMap['postOwnerDocumentID'];
    if (postOwnerDocumentID == null || postOwnerDocumentID is! String){
      debugPrint('[NewsFeedData] Cannot read postOwnerDocumentID from the given dataMap, set to default value');
      postOwnerDocumentID = '';
    }

    List<CommentData> recentComments = [];
    var recentCommentData = dataMap['recentComments'];
    if (recentCommentData == null || recentCommentData is! List){
      debugPrint('[NewsFeedData] Cannot read recentComments from the given dataMap, set to default value');
    }
    else{
      List.castFrom(recentCommentData).forEach((d){

        // debugPrint('${d['uid']}');
        // debugPrint('${d['comment']}');
        // debugPrint('${d['nickname']}');
        // debugPrint('${d['avatarURL']}');
        // debugPrint('${d['time']}');

        DateTime instanceTime = Timestamp(d['time']['_seconds'], d['time']['_nanoseconds']).toDate();

        recentComments.add(
          CommentData(
            uid: d['uid'],
            comment: d['comment'],
            nickname: d['nickname'],
            avatarURL: d['avatarURL'],
            time: instanceTime,
          )
        );
      });
    }

    return NewsFeedData._internal(

      uid: uid,
      nickname: nickname,
      postID: postID,
      description: description,
      avatarURL: avatarURL,
      mood: instanceMood,
      postTime: postTime,
      supported: supported,
      supportCount: supportCount,
      commentCount: commentCount,
      postDocumentID: postDocumentID,
      postOwnerDocumentID: postOwnerDocumentID,
      recentComments: recentComments,
    );
  }

  static NewsFeedData createFromPostData({PostData data}){
    
    UserProfile userProfile = GlobalState.userProfile;

    var postID = data.postID;
    if (postID == null) postID = '';

    var description = data.description;
    if (description == null) description = '';

    var mood = data.mood;
    if (mood == null) mood = Mood(typeCode: -1, intensity: 0);

    return NewsFeedData._internal(
      uid: userProfile.uid,
      nickname: userProfile.nickname,
      postID: postID,
      description: description,
      avatarURL: userProfile.avatarURL,
      mood: mood,
      postTime: DateTime.now(),
      supported: false,
      supportCount: 0,
      commentCount: 0,
      postDocumentID: '',
      postOwnerDocumentID: userProfile.documentID,
      recentComments: [],
    );
  }

  NewsFeedData._internal({
    this.uid, 
    this.nickname,
    this.postID,
    this.description, 
    this.avatarURL,
    this.mood, 
    this.postTime, 
    this.supported, 
    this.supportCount, 
    this.commentCount, 
    this.postDocumentID, 
    this.postOwnerDocumentID,
    this.recentComments
  });

  final String uid;
  final String nickname;
  final String postID;
  final String avatarURL;
  final Mood mood;
  final String description;
  final DateTime postTime;

  bool supported;

  int supportCount;
  int commentCount;

  final String postDocumentID;
  final String postOwnerDocumentID;

  final List<CommentData> recentComments;
}

class PostData {

  PostData({this.mood, this.description});

  Mood mood;
  String postID;
  String description;
}

class CommentData {

  CommentData({this.uid, this.comment, this.avatarURL, this.nickname, this.time});

  String uid;
  String comment;
  String nickname;
  String avatarURL;
  DateTime time;

}