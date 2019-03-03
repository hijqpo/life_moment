import 'package:flutter/material.dart';

enum RelationshipStatus {

  Friend,
  SentRequest,
  ReceivedRequest,
  Stranger,
  Unknown,
}

class RelationshipData {

  RelationshipData({this.score, this.status});

  int score;
  String status;
}


class Relationship {

  Relationship({
    this.uid1,
    this.documentID1,
    this.uid2,
    this.documentID2,
    this.isFriend = false,
    this.sentRequest = false,
    this.receivedRequest = false,
    this.hiddenScore,
    this.ranking
  });

  String uid1;
  String documentID1;

  String uid2;
  String documentID2;

  bool isFriend;
  bool sentRequest;
  bool receivedRequest;

  int hiddenScore;

  int ranking;

  RelationshipStatus get status{

    if (isFriend || (sentRequest && receivedRequest)){
      return RelationshipStatus.Friend;
    }

    if (!isFriend && sentRequest){
      return RelationshipStatus.SentRequest;
    }

    if (!isFriend && receivedRequest){
      return RelationshipStatus.ReceivedRequest;
    }

    if (!isFriend){
      return RelationshipStatus.Stranger;
    }

    return RelationshipStatus.Unknown;
  }
} 