
import 'package:life_moment/data_structures/mood_data.dart';

class NewsFeedData {

  NewsFeedData({
    this.uid, 
    this.nickname, 
    this.description, 
    this.mood, 
    this.postTime, 
    this.noticed, 
    this.noticeCount = 0, 
    this.commentCount = 0, 
    this.documentID, 
    this.ownerDocumentID
  });

  final String uid;
  final String nickname;
  final Mood mood;
  final String description;
  final DateTime postTime;

  final bool noticed;

  final int noticeCount;
  final int commentCount;

  final String documentID;
  final String ownerDocumentID;
}

class PostData {

  PostData({this.mood, this.description});

  Mood mood;
  String description;
}