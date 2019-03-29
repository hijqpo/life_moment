import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/new_post_view.dart';
import 'package:life_moment/views/structure.dart';
import 'package:life_moment/widgets/error_text.dart';

// Widget
import 'package:life_moment/widgets/router_widgets.dart';

class HomeView extends StatefulWidget {

  //HomeView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView>{

  // State variable
  String _errorMessage = '';
  bool _loading = false;


  @override
  void initState(){
    super.initState();
    debugPrint('Home View Initializing...');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (GlobalState.isNewsFeedDataEmpty()){
      initialRefresh();
    }
  }
 
  void _onNewPostPressed(){
    Navigator.push(context, SlidePageRoute(widget: NewPostView(), offset: SlideDirection.up));
  }

  Future<void> initialRefresh() async{

    if (this.mounted){
      setState(() {
        _loading = true;
      });
    }
    OperationResponse response = await PostManagement.loadNewsFeed();

    if (response.isError && this.mounted){
      setState(() {
        _loading = false;
        _errorMessage = response.message;
      });
    }
    else{

      if (this.mounted) {
        setState(() {
          _loading = false;
          _errorMessage = '';
        });
      }
    }
  }

  Future<void> onRefresh() async{

    if (!_loading){
      OperationResponse response = await PostManagement.loadNewsFeed();
      if (response.isError && this.mounted){
        setState(() {
          _loading = false;
          _errorMessage = response.message;
        });
      }
      else{
        setState(() {
          _loading = false;
          _errorMessage = '';
        });
      }
      debugPrint('[Home View] Refreshed');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // New post bar
          _buildNewPostBar(),

          // Messages
          _buildErrorText(_errorMessage),
          _buildLoadingText(),

          // Render list
          _buildNewsFeedList(),
        ]
      ),
    );
  }

  Widget _buildNewPostBar(){
    
    UserProfile userProfile = GlobalState.userProfile;
    String _avatarURL = userProfile.avatarURL;
    String _nickname = userProfile.nickname;

    return FlatButton(

      onPressed: _onNewPostPressed,
      padding: const EdgeInsets.all(0),
      child: Container(
          
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.black45)
              )
            ),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              
              CircleAvatar(
                backgroundImage: NetworkImage(_avatarURL),
              ),
              Expanded(
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Hello $_nickname ~ What is in your mind?',
                    style:TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.start,
                  )
                ),
              ),
            ]
          ),
        )
      ),
    );
  }

  Widget _buildNewsFeedList(){

    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          //key: PageStorageKey(GlobalState.newsFeedDataList),
          children: WidgetFactory.newsFeedListBuilder(),
        )
      ),
    );
  }

  Widget _buildLoadingText(){

    if (_loading){
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Fetching Newsfeeds...',
          style: TextStyle(
            //color: Colors.red,
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          )
        )
      );
    }
    return Container();
  }

  Widget _buildErrorText(String message){

    return ErrorText(message);
  }
}
