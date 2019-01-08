import 'package:flutter/material.dart';
import 'package:life_moment/data/news_feed_data.dart';


class NewsFeed extends StatefulWidget {

  NewsFeed(this.data);

  final NewsFeedData data;

  @override
  State<StatefulWidget> createState() {
    return new _NewsFeedState();
  }
}

class _NewsFeedState extends State<NewsFeed> {

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 5.0),

      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black87),
      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
      // ),

      child: Card(

        child: Column(

          children: <Widget>[

            ListTile(
              leading: Icon(Icons.child_care),
              title: Text(widget.data.name),
              subtitle: Text(widget.data.description),
            ),

            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('LIKE'),
                    onPressed: () { /* ... */ },
                  ),
                  FlatButton(
                    child: const Text('DISLIKE'),
                    onPressed: () { /* ... */ },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ); 
  }


}