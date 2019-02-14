import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/data_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/new_post_view.dart';

// Widget
import 'package:life_moment/widgets/news_feed/news_feed.dart';
import 'package:life_moment/widgets/router_widgets.dart';

// data
import 'package:life_moment/data_structures/news_feed_data.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {

  // final _postFieldController = TextEditingController();

  // bool _showPostExpand = false;
  // bool _showPostDetailInput = false;

  // void onPostContentFieldChange(String text) {
  //   setState(() {
  //     if (text != '') {
  //       _showPostExpand = true;
  //     } else {
  //       _showPostExpand = false;
  //       _showPostDetailInput = false;
  //     }
  //   });
  // }

  // void onPostContentExpand() {
  //   setState(() {
  //     _showPostDetailInput = !_showPostDetailInput;
  //   });
  // }

  void onNewPostPressed(){
    Navigator.push(context, SlidePageRoute(widget: NewPostView(), offset: SlideDirection.up));
  }

  Future<void> onRefresh() async{

    OperationResponse response = await DataManagement.loadNewsFeed();
    setState(() {
      
    });
    return;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // New post bar
            FlatButton(

              onPressed: onNewPostPressed,
              child: Container(
                  
                padding: EdgeInsets.symmetric(vertical: 10.0),

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
                        
                      ),
                      Expanded(
                        child: Container(

                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Hello ${GlobalState.userProfile.nickname} ~ What is in your mind?',
                            style:TextStyle(fontWeight: FontWeight.w300),
                            textAlign: TextAlign.start,
                          )
                        ),
                      ),
                      // _showPostExpand
                      //     ? IconButton(
                        //         icon: Icon(Icons.details),
                        //         onPressed: onPostContentExpand,
                        //       )
                        //     : Container()
                    ]
                  ),
                )
              ),
            ),

          //   Expanded(
          //     child: ListView(
          //       shrinkWrap: true,
          //       padding: const EdgeInsets.all(20.0),
          //       children: <Widget>[
                  
          //         //NewsFeed(),

          //       ],
          //   )
          // ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(

                children: WidgetFactory.newsFeedListBuilder(),
              )

            ),
          )
        ]
      ),
    );
  }
}

