import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';


enum NewsFeedType {
  Normal,
  Warning,

}


class NewsFeed extends StatefulWidget {

  NewsFeed(this.data, {this.type: NewsFeedType.Normal});

  final NewsFeedData data;
  final NewsFeedType type;

  @override
  State<StatefulWidget> createState() {
    return new _NewsFeedState();
  }
}

class _NewsFeedState extends State<NewsFeed> {


  @override
  Widget build(BuildContext context) {

    String nickname = widget.data.nickname == null ? 'Anonymous' : widget.data.nickname;
    String description = widget.data.description == null ? '<No Description>' : widget.data.description;
    String postTime = widget.data.postTime == null ? 'NO TIME RECORD' : widget.data.postTime.toLocal().toIso8601String();

    Mood mood = widget.data.mood;
    
    


    return Container(

      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),

      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black87),
      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
      // ),

      child: Card(
        
        color: mood.moodColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(

            children: <Widget>[

              ListTile(
                leading: CircleAvatar(),
                title: Text(
                  nickname, 
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  )
                ),
                subtitle: Text(postTime),
                trailing: mood.moodIcon,
                
              ),

              // ButtonTheme.bar( // make buttons use the appropriate styles for cards
              //   child: ButtonBar(
              //     children: <Widget>[
              //       FlatButton(
              //         child: const Text('LIKE'),
              //         onPressed: () { /* ... */ },
              //       ),
              //       FlatButton(
              //         child: const Text('DISLIKE'),
              //         onPressed: () { /* ... */ },
              //       ),
              //     ],
              //   ),
              // ),

            ],
          ),
        ),
      ),
    ); 
  }


}