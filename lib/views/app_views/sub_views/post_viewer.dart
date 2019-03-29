import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/utilities.dart';
import 'package:life_moment/widgets/app_bars/app_bar_builder.dart';

class PostViewer extends StatefulWidget {

  PostViewer(this.data, {this.focusComment = false});

  final NewsFeedData data;
  final bool focusComment;

  @override
  _PostViewerState createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {

  final _replyFieldController = TextEditingController();
  final _replyFieldFocusNode = FocusNode();
  NewsFeedData _data;
  UserProfile _userProfile;

  String _errorMessage = '';
  bool _supportLoading = false;
  bool _commentLoading = false;

  @override
  void initState(){
    super.initState();
    _data = widget.data;
    _userProfile = GlobalState.userProfile;
    // debugPrint('$_data');
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if (widget.focusComment){
      FocusScope.of(context).requestFocus(_replyFieldFocusNode);
    }
  }

  bool _operationEnabled(){
    if (_supportLoading || _commentLoading){
      return false;
    }
    return true;
  }

  void _onSupportPressed(){

  }

  void _onCommentPressed(){

    if (_replyFieldFocusNode.hasFocus){
      _replyFieldFocusNode.unfocus();
    }
    else{
      FocusScope.of(context).requestFocus(_replyFieldFocusNode);
    }
  }

  Future<void> _onCommentSubmitted(String val) async{

    debugPrint('[Notification View] Submitted comment: $val');
    if (val != ''){

      String uid = GlobalState.userProfile.uid;
      String postDocumentID = widget.data.postDocumentID;

      _replyFieldController.text = '';

      if (mounted){
        setState(() {
          _commentLoading = true;
        });
      }
      OperationResponse response = await PostManagement.commentPost(uid, val, postDocumentID);
      
      if (mounted){
        if (response.isError){
          setState(() {
            _errorMessage = response.message;
            _commentLoading = false;
          });
        }
        else{
          
          setState(() {
            _commentLoading = false;
            _data.recentComments.add(
              CommentData(
                uid: _userProfile.uid,
                nickname: _userProfile.nickname,
                avatarURL: _userProfile.avatarURL,
                comment: val,
                time: DateTime.now(),
              )
            );
          });

        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    String title = '${_data.nickname}\'s post';

    return Scaffold(

      appBar: AppBarBuilder.titledAppBar(title),

      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[

                  _buildTopSection(),
                  // Divider(),
                  _buildEmotionList(),
                  Divider(),
                  _buildDescription(),
                  Divider(),
                  _buildActionList(),
                  _buildSupportCount(),
                  Divider(),
                  _buildCommentList(),
                  
                ],
              )
            ),
            Divider(),
            _buildReplyField(),
          ]

        )
      )
          

    );
  }

  Widget _buildTopSection(){

    String postTime = displayTime(_data.postTime);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_data.avatarURL),
      ),
      title: Row(
        children: <Widget>[
          Text(
            _data.nickname, 
            style: TextStyle(
              fontWeight: FontWeight.w600
            )
          ),
          // _isSelfPost() ? Icon(Icons.star, color: Colors.yellow,) : Container()
        ]
      ),
      subtitle: Text('$postTime'),
      trailing: Column(
        children: <Widget>[
          _data.mood.colorMoodIcon,
          Text('Intensity: ${_data.mood.intensity}'),
        ]
      )
      
    );
  }

  Widget _buildEmotionList(){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'No Emotion',
          style: TextStyle(
            fontWeight: FontWeight.w300
          )
        )
      )
    );
  }

  Widget _buildDescription(){

    String description = _data.description;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description == '' ? 'No Emotion' : description,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500
          )
        )
      )
    );
  }

  Widget _buildActionList(){

    bool supported = _data.supported;

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

                onPressed: _operationEnabled() ? (){} : null,
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
    );
  }

  Widget _buildSupportCount(){

    String count = _data.supportCount.toString();
    String support = 'Support';
    if (_data.supportCount > 1){
      support = 'Supports';
    }

    Widget loadingIndicator = Container();
    if (_commentLoading || _supportLoading){
      loadingIndicator = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2,)
      );
    }

    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          alignment: Alignment.centerLeft,
          child: Text(
            '$count $support',
            style: TextStyle(
              fontWeight: FontWeight.w700
            )
          )
        ),

        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: loadingIndicator,
        )

      ] 
    );
  }

  Widget _buildCommentList(){

    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: WidgetFactory.commentListBuilder(_data.recentComments),
      )
    );
  }

  Widget _buildReplyField(){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      // alignment: Alignment.bottomCenter,
      child: TextField(
        controller: _replyFieldController,
        focusNode: _replyFieldFocusNode,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Write comment...',
          
          border: InputBorder.none
        ),
        onSubmitted: _operationEnabled() ? _onCommentSubmitted : null,
      )
    );

  }

  @override
  void dispose(){

    _replyFieldController.dispose();
    _replyFieldFocusNode.dispose();
    super.dispose();
  }

}