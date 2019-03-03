import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/state.dart';


enum NewsFeedType {
  Normal,
  Warning,
}


class NewsFeed extends StatefulWidget {

  NewsFeed(this.data, {this.type: NewsFeedType.Normal, Key key}): super(key: key);

  final NewsFeedData data;
  final NewsFeedType type;

  @override
  State<StatefulWidget> createState() {
    return new _NewsFeedState(supportCount: data.supportCount, supported: data.supported);
  }
}

class _NewsFeedState extends State<NewsFeed>{

  _NewsFeedState({this.supportCount = 0, this.commentCount = 0, this.supported}){
    if (this.supported == null){
      this.supported = false;
    }
  }

  int supportCount;
  int commentCount;
  bool supported;

  bool loading = false;

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

  Future<void> _onSupportPressed() async{

    if (this.mounted){
      setState((){
        loading = true;
      });
    }

    OperationResponse response = await PostManagement.supportPost(
      postDocumentID: widget.data.postDocumentID, 
    );

    if (response.isError){}
    else{}

    if (this.mounted) {
      setState(() {
        NewsFeedData instanceData = widget.data;
        
        if (supported){
          instanceData.supportCount -= 1;
        }
        else {
          instanceData.supportCount += 1;
        }
        instanceData.supported = !instanceData.supported;
        GlobalState.updateNewsFeedDataList(instanceData);

        supportCount = instanceData.supportCount;
        supported = instanceData.supported;
        loading = false;
      });
    }
  }

  void _onCommentPressed(){

  }

  bool _operationEnabled(){

    if (widget.data.postOwnerDocumentID == null || widget.data.postDocumentID == ''){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    String nickname = widget.data.nickname == null ? 'Anonymous' : widget.data.nickname;
    String description = (widget.data.description == null ||  widget.data.description == '') ? '<No Description>' : widget.data.description;
    String postTime = widget.data.postTime == null ? 'NO TIME RECORD' : _displayTime(widget.data.postTime.toLocal());

    String avatarURL = widget.data.avatarURL == null ? UserProfile.defaultAvatarURL : widget.data.avatarURL;

    Mood mood = widget.data.mood;
  

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      child: Stack(
        children:<Widget>[ 
          
          Card(
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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(avatarURL),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        nickname, 
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        )
                      ),
                      _isSelfPost() ? Icon(Icons.star, color: Colors.yellow,) : Container()
                    ]
                  ),
                  subtitle: Text(postTime),
                  trailing: mood.colorMoodIcon,
                  
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    description,

                  )
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
     
                      Icon(
                        FontAwesomeIcons.solidHeart,
                        size: 20,
                        color: Colors.red[200],
                        // color: Colors.grey,
                      ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 4),),
                      Text('$supportCount'),
                      
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

                            onPressed: _operationEnabled() ? _onSupportPressed : null,
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: supported ? Colors.red[200] : Colors.grey,
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 4),),
                                Text('Support')

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
        loading
        ? Positioned.fill(

          child: Container(
            color: Colors.black38,
            child: Center(
              child: Text('Loading...', style:TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500))
            )
          )
          //),
        )
        : Container()
        ],
      ),
    ); 
  }


}