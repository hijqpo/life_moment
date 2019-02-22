import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/widgets/news_feed/news_feed.dart';

class WidgetFactory {

  static List<NewsFeed> newsFeedListBuilder(){

    List<NewsFeed> list = [];

    List<NewsFeedData> dataList = GlobalState.newsFeedDataList;
    dataList.sort((a, b)  {
      return b.postTime.compareTo(a.postTime);
    });


    dataList.forEach((data){

      list.add(NewsFeed(data));
    });

    return list;
  }
}