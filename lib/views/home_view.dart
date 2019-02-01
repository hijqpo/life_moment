import 'package:flutter/material.dart';
import 'package:life_moment/state.dart';

// Widget
import 'package:life_moment/widgets/news_feed/news_feed.dart';

// data
import 'package:life_moment/data_structures/news_feed_data.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  final _postFieldController = TextEditingController();

  bool _showPostSubmit = false;

  void onPostContentFieldChange(String text) {
    setState(() {
      if (text != '') {
        _showPostSubmit = true;
      } else {
        _showPostSubmit = false;
      }
    });
  }

  void onPostContentExpand() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // New post bar
            Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black45)
                      )
                    ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText:
                                          'Hello ${GlobalState.userProfile.data['nickname']} ~ What is in your mind?',
                                      hintStyle:
                                          TextStyle(fontWeight: FontWeight.w300),
                                      border: InputBorder.none),
                                  controller: _postFieldController,
                                  onChanged: onPostContentFieldChange,
                                )

                                // Text(
                                //   'Hello ${GlobalState.userProfile.data['nickname']} ~ What is in your mind?',
                                //   style: TextStyle(fontWeight: FontWeight.w300)
                                // )
                                ),
                          ),
                          _showPostSubmit
                              ? IconButton(
                                  icon: Icon(Icons.details),
                                  onPressed: onPostContentExpand,
                                )
                              : Container()
                      ]
                    ),
                  ]),
                )),

            Expanded(
                child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                TextField(
                    decoration: InputDecoration(
                        hintText:
                            'Hello ${GlobalState.userProfile.data['nickname']} ~ What is in your mind?',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300)))
              ],
            )),
          ]),
    );
  }
}
