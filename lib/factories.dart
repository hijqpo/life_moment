import 'package:flutter/material.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/widgets/news_feed/news_feed.dart';

class WidgetFactory {

  static List<NewsFeed> newsFeedListBuilder(){

    List<NewsFeed> list = [];

    GlobalState.newsFeedDataList.forEach((data){

      list.add(NewsFeed(data));
    });

    return list;
  }
}