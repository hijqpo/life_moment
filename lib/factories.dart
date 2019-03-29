import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/notification_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/widgets/comment_cell.dart';
import 'package:life_moment/widgets/news_feed/news_feed.dart';
import 'package:life_moment/widgets/notification_cell.dart';
import 'package:life_moment/widgets/search_result_cell.dart';

class WidgetFactory {

  static List<Widget> newsFeedListBuilder(){

    List<Widget> list = [];

    // The newly added post from the temp news feed data list
    List<NewsFeedData> tempDataList = GlobalState.newsFeedDataTempList;
    tempDataList.sort((a, b)  {
      return b.postTime.compareTo(a.postTime);
    });

    tempDataList.forEach((data){
      list.add(NewsFeed(data, key: UniqueKey()));
    });

    // The loaded news feed data list
    List<NewsFeedData> dataList = GlobalState.newsFeedDataList;

    dataList.sort((a, b)  {
      return b.postTime.compareTo(a.postTime);
    });

    dataList.forEach((data){
      list.add(NewsFeed(data, key: UniqueKey()));
    });

    // Append a load more button if there are 10 or more element
    if (list.length >= 10){
      list.add(
        RaisedButton(
          onPressed: (){},
          child: Text('Load More...'),
        )
      );
    }
    return list;
  }

  static List<Widget> searchResultListBuilder(){

    List<Widget> list = [];

    // Can add sorting rules here...
    List<UserProfile> dataList = GlobalState.searchResultList;

    dataList.forEach((data){
      
      list.add(SearchResultCell(data: data));
    });

    if (list.length == 0){
      list.add(
        Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text('No matched result')
          ),
        )
      );
    }
    return list;
  }

  static List<Widget> notificationListBuilder(){

    List<Widget> list = [];

    List<NotificationData> dataList = GlobalState.notificationList;
    dataList.sort((a, b)  {
      return b.time.compareTo(a.time);
    });

    dataList.forEach((data){
      
      list.add(NotificationCell(data));
    });

    if (list.length == 0){
      list.add(
        Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text('No notification')
          ),
        )
      );
    }
    return list;
  }

  static List<Widget> commentListBuilder(List<CommentData> dataList){

    List<Widget> list = [];
    if (dataList == null || dataList.length == 0){
      list.add(
        Text(
          'No Comments',
          style: TextStyle(
            fontWeight: FontWeight.w300
          )
        )
      );
      return list; 
    }

    dataList.sort((a, b)  {
      return b.time.compareTo(a.time);
    });

    dataList.forEach((data){

      list.add(CommentCell(data));
    });

    return list;
  }
}