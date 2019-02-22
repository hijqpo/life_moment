import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/services/operation_management.dart';
import 'package:life_moment/state.dart';


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
    return new _NewsFeedState(noticeCount: data.noticeCount, noticed: data.noticed);
  }
}

class _NewsFeedState extends State<NewsFeed> {

  _NewsFeedState({this.noticeCount = 0, this.commentCount = 0, this.noticed});

  int noticeCount;
  int commentCount;

  bool noticed = false;

  String _displayTime(DateTime t){

    DateTime currentTime = DateTime.now();

    Duration diff = currentTime.difference(t);

    // Cases of post time within today
    if (diff.inDays == 0){
      
      if (diff.inHours == 0){

        if (diff.inMinutes == 0){

          if (diff.inSeconds < 10){
            return 'Just Now';
          }

          return '${diff.inSeconds} Seconds';
        }

        return '${diff.inMinutes} Minutes';
      }

      return '${diff.inHours} Hours';

    }
    else if (diff.inDays == 1){

      return 'Yesterday ${t.hour}:${t.minute}';
    }
    else if (diff.inDays < 365){

      return '${t.month} - ${t.day}';
    }
    else{
      return '${t.year} - ${t.month} - ${t.day}';
    }
  }

  bool _isSelfPost(){
    // Check if this feed is post by current user
    if (GlobalState.userProfile.uid == widget.data.uid){
      return true;
    }
    return false;
  }

  void _onNoticePressed(){

    setState(() {
      if (noticed) noticeCount -= 1;
      else noticeCount += 1;

      noticed = ! noticed;
    });

    OperationManagement.noticePost(
      postDocumentID: widget.data.documentID, 
      postOwnerDocumentID: widget.data.ownerDocumentID
    );

  }

  bool _operationEnabled(){

    if (widget.data.ownerDocumentID == null || widget.data.documentID == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    String _nickname = widget.data.nickname == null ? 'Anonymous' : widget.data.nickname;
    String _description = (widget.data.description == null ||  widget.data.description == '') ? '<No Description>' : widget.data.description;
    String _postTime = widget.data.postTime == null ? 'NO TIME RECORD' : _displayTime(widget.data.postTime.toLocal());

    Mood mood = widget.data.mood;
  

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      child: Card(
        // color: mood.moodColor,
        
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: mood.moodColor,
              width: 5,
            )
          ),
          padding: const EdgeInsets.all(4.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              ListTile(
                leading: CircleAvatar(),
                title: Row(
                  children: <Widget>[
                    Text(
                      _nickname, 
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      )
                    ),
                    _isSelfPost() ? Icon(Icons.star, color: Colors.yellow,) : Container()
                  ]
                ),
                subtitle: Text(_postTime),
                trailing: mood.colorMoodIcon,
                
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                margin: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  _description,

                )
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                margin: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
     
                    Icon(
                      Icons.visibility,
                      // color: Colors.grey,
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 4),),
                    Text('$noticeCount'),
                    
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8),),

                    Icon(
                      Icons.comment,
                      // color: Colors.grey,
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 4),),
                    Text('$commentCount'),
                  ],
                )
              ),

              Divider(),

              Container(

                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: Container(
                        height: 32,
                        child: FlatButton(

                          onPressed: _operationEnabled() ? _onNoticePressed : null,
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Icon(
                                Icons.visibility,
                                color: noticed ? Colors.blue : Colors.grey,
                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 4),),
                              Text('Notice')

                            ]
                          ),

                        )
                      )
                    ),
                    Expanded(
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1, color: Colors.black12),
                            right: BorderSide(width: 1, color: Colors.black12)
                          )
                        ),

                        child: FlatButton(

                          onPressed: _operationEnabled() ? (){} : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Icon(Icons.comment),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 2),),
                              Text('Comment')

                            ]
                          ),

                        )
                      )
                    ),
                    Expanded(
                      child: Container(
                        height: 32,
                        child: FlatButton(

                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text('🎁', style: TextStyle(fontSize: 20)),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 4),),
                              Text('Present')

                            ]
                          ),

                        )
                      )
                    ),




                  ],)
              )
            ],
          ),
        ),
      ),
    ); 
  }


}