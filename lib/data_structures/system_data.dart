
import 'package:flutter/foundation.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/state.dart';

class OperationResponse {

  OperationResponse(this.code, this.isError, this.message, {this.data});

  static OperationResponse ok = OperationResponse(0, false, 'OK');

  final int code;
  final bool isError;
  final String message;
  final dynamic data;


  @override
  String toString(){
    return 'Code: $code\nisError: $isError\nMessage: $message';
  }
}


class UserProfile {

  static String defaultNickname = 'Anonymous';
  static String defaultAvatarURL = 'https://firebasestorage.googleapis.com/v0/b/life-moment-89403.appspot.com/o/profile_pics%2Favatar.png?alt=media&token=da395a0e-7e14-4b00-bb90-86e3aa7e5474';

  static UserProfile createFromDataMap({@required Map<dynamic, dynamic> dataMap}){

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
      gold: dataMap['gold'] == null ? 0 : dataMap['gold'],

      relationship: RelationshipData(score: friendScore, status: friendStatus),
    );
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
    this.gold,
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
  int gold;

  RelationshipData relationship;

  String uid;
  String documentID;

  @override
  String toString(){

    return '{nickname: $nickname, email: $email, gender: $gender, tel: $tel, avatarURL: $avatarURL, ' +
    'postCount: $postCount, friendCount: $friendCount, score: $score, gold: $gold, uid: $uid, documentID: $documentID';
  }
}