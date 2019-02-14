
import 'package:life_moment/data_structures/mood_data.dart';

class NewsFeedData {

  NewsFeedData({this.uid, this.nickname, this.description, this.mood, this.postTime});

  final String uid;
  final String nickname;
  final Mood mood;
  final String description;
  final DateTime postTime;

}

class PostData {

  PostData({this.mood, this.description});

  Mood mood;
  String description;
}