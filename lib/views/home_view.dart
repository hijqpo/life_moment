import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/new_post_view.dart';

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

  // _HomeViewState(){
  //   onRefresh();
  // }

  @override
  void initState(){
    super.initState();
    // onRefresh();
    debugPrint('Home View Initializing...');
  }

  // @override
  // void didUpdateWidget(HomeView oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   //if (oldWidget.)
  //   onRefresh();
  //   debugPrint('haha');

  // }


  void onNewPostPressed(){
    Navigator.push(context, SlidePageRoute(widget: NewPostView(), offset: SlideDirection.up));
  }

  Future<void> onRefresh() async{

    OperationResponse response = await PostManagement.loadNewsFeed();
    setState(() {
      debugPrint('[Home View] Refreshed');
      //GlobalState.newsFeedDataList.add(NewsFeedData(postTime: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // New post bar
          _buildNewPostBar(),
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

      onPressed: onNewPostPressed,
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

}

