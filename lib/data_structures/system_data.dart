
import 'package:flutter/foundation.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/state.dart';

class OperationResponse {

  OperationResponse(this.code, this.isError, this.message);

  static OperationResponse ok = OperationResponse(0, false, 'OK');

  final int code;
  final bool isError;
  final String message;

  @override
  String toString(){
    return 'Code: $code\nisError: $isError\nMessage: $message';
  }
}


class UserProfile {

  static String defaultNickname = 'Anonymous';
  static String defaultAvatarURL = 'https://firebasestorage.googleapis.com/v0/b/life-moment-89403.appspot.com/o/profile_pics%2Favatar.png?alt=media&token=da395a0e-7e14-4b00-bb90-86e3aa7e5474';

  static final Map<String, UserProfile> _cache = {};


  static UserProfile createFormDataMap({@required Map<dynamic, dynamic> dataMap}){

    var friendStatus = dataMap['friendStatus'];
    if (friendStatus == null || friendStatus is! String){
      friendStatus = 'stranger';
    }

    var friendScore = dataMap['friendScore'];
    if (friendScore == null || friendScore is! int){
      friendScore = 0;
    }


    return UserProfile._internal(

      documentID: dataMap['documentID'] == null ? '' : dataMap['documentID'],
      uid: dataMap['uid'] == null ? '' : dataMap['uid'],

      nickname: dataMap['nickname'] == null ? defaultNickname: dataMap['nickname'],
      email: dataMap['email'] == null ? '' : dataMap['email'],
      gender: dataMap['gender'] == null ? '' : dataMap['gender'],
      tel: dataMap['tel'] == null ? '' : dataMap['tel'],
      avatarURL: dataMap['avatarURL'] == null ? defaultAvatarURL : dataMap['avatarURL'],

      postCount: dataMap['postCount'] == null ? 0 : dataMap['postCount'],
      friendCount: dataMap['friendCount'] == null ? 0 : dataMap['friendCount'],
      score: dataMap['score'] == null ? 0 : dataMap['score'],

      relationship: RelationshipData(score: friendScore, status: friendStatus),
    );
  }

  factory UserProfile({Map<String, dynamic> dataMap}){

    String uidKey = dataMap['uid'];
    if (_cache.containsKey(dataMap['uid'])){
      return _cache[uidKey];
    }
    else{
      final UserProfile instanceUserProfile = UserProfile.createFormDataMap(dataMap: dataMap);
      _cache[uidKey] = instanceUserProfile;
      return instanceUserProfile;
    }
  }

  UserProfile._internal({
    @required this.documentID, 
    this.nickname, 
    this.email, 
    this.gender, 
    this.tel,
    this.uid, 
    this.avatarURL,
    this.postCount,
    this.friendCount,
    this.score,
    this.relationship,
  });

  String nickname;
  // String firstName;
  // String lastName;
  String email;
  String gender;
  String tel;

  String avatarURL;

  int postCount;
  int friendCount;
  int score;

  RelationshipData relationship;

  String uid;
  String documentID;
}