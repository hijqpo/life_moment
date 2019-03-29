import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/utilities.dart';
import 'package:life_moment/views/app_views/sub_views/post_viewer.dart';
import 'package:life_moment/views/structure.dart';


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
    return new _NewsFeedState();
  }
}

class _NewsFeedState extends State<NewsFeed>{

  @override
  void initState(){
    super.initState();

    NewsFeedData data = widget.data;

    _supportCount = data.supportCount;
    if (_supportCount == null){
      _supportCount = 0;
    }

    _commentCount = data.commentCount;
    if (_commentCount == null){
      _commentCount = 0;
    }

    _supported = data.supported;
    if (_supported == null){
      _supported = false;
    }

    _nickname = data.nickname;
    if (_nickname == null){
      _nickname = UserProfile.defaultNickname;
    }

    _description = data.description;
    if (_description == null || _description == ''){
      _description = '<No Description>';
    }

    _postTime = 'NO TIME RECORD';
    if (data.postTime != null){
      _postTime = displayTime(data.postTime.toLocal());
    }

    _avatarURL = data.avatarURL;
    if (_avatarURL == null){
      _avatarURL = UserProfile.defaultAvatarURL;
    }

    _mood = data.mood;
    if (_mood == null){
      _mood = Mood(intensity: 0, typeCode: 0);
    }
  }

  String _nickname;
  String _avatarURL;
  String _description;
  String _postTime;
  Mood _mood;
  int _supportCount;
  int _commentCount;
  bool _supported;

  bool _loading = false;

  bool _isSelfPost(){

    String uid = GlobalState.userProfile.uid;

    // Check if this feed is post by current user
    if (uid == widget.data.uid){
      return true;
    }
    return false;
  }

  Future<void> _onSupportPressed() async{

    if (mounted){
      setState((){
        _loading = true;
      });
    }

    OperationResponse response = await PostManagement.supportPost(
      GlobalState.userProfile,
      postDocumentID: widget.data.postDocumentID, 
    );

    if (response.isError){}
    else{}

    if (mounted) {
      setState(() {
        NewsFeedData instanceData = widget.data;
        
        if (_supported){
          instanceData.supportCount -= 1;
        }
        else {
          instanceData.supportCount += 1;
        }
        instanceData.supported = !instanceData.supported;
        GlobalState.updateNewsFeedDataList(instanceData);

        _supportCount = instanceData.supportCount;
        _supported = instanceData.supported;
        _loading = false;
      });
    }
  }

  void _onCommentPressed(){

    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) => PostViewer(widget.data, focusComment: true,))
    );
  }

  void _onBodyPressed(){
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) => PostViewer(widget.data, focusComment: false,))
    );
  }

  bool _operationEnabled(){

    if (widget.data.postOwnerDocumentID == null || widget.data.postDocumentID == ''){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      child: Stack(
        children:<Widget>[ 
          
          Card(
          // color: mood.moodColor,
          
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _mood.moodColor,
                  width: 5,
                )
              ),
              padding: const EdgeInsets.all(4.0),
              child: Column(

                children: <Widget>[

                  _buildUserSection(),

                  Divider(),

                  _buildActionList()

              ],
            ),
          ),
        ),
      
          _buildLoadingCover()
        ],
      ),
    ); 
  }




  Widget _buildUserSection(){

    return FlatButton(
      onPressed: _onBodyPressed,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_avatarURL),
            ),
            title: Row(
              children: <Widget>[
                Text(
                  '$_nickname', 
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  )
                ),
                _isSelfPost() ? Icon(Icons.star, color: Colors.yellow,) : Container()
              ]
            ),
            subtitle: Text('$_postTime'),
            trailing: _mood.colorMoodIcon,
            
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              '$_description',

            )
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            //margin: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      size: 20,
                      color: Colors.red[200],
                      // color: Colors.grey,
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 4),),
                    Text('$_supportCount'),
                    
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8),),

                    Icon(
                      Icons.comment,
                      // color: Colors.grey,
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 4),),
                    Text('$_commentCount'),
                  ],
                )
                
              ]
            )
          ),
        ]    
      )   
    );
  }

  Widget _buildActionList(){

    return Container(
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
                      color: _supported ? Colors.red[200] : Colors.grey,
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

                onPressed: _operationEnabled() ? _onCommentPressed : null,
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
        ],
      )
  );
  }

  Widget _buildLoadingCover(){

    if (_loading){
      return Positioned.fill(

        child: Container(
          color: Colors.black38,
          child: Center(
            child: Text('Loading...', style:TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500))
          )
        )
        //),
      );
    }

    return Container();
  }




}