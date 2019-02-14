import 'package:flutter/material.dart';
import 'package:life_moment/services/user_management.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<String> litems = [];
  final TextEditingController eCtrl = new TextEditingController();
  bool _isFavorited = true;
  @override
  Widget build (BuildContext ctxt) {
    return _buildList(context);
  }
  ListView _buildList(context) {
    return ListView.builder(
      
      itemCount: 10,
      
      itemBuilder: (context, int) {
        
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.accessible),
              title: Text('Help'),
              subtitle: Text('This is a person who needs help'),
              trailing: IconButton(
                icon: (_isFavorited ? Icon(Icons.mood_bad) : Icon(Icons.mood)),
                color: Colors.blue,
                onPressed: _toggleFavorite,
              )
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Likes'),
                )
              ],
            ),

            TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {});
              },
              decoration: new InputDecoration(
                hintText: "Quick Reply...",
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Respond'),
                )
              ],
            ),
            
        //     Expanded(
        //     child: new ListView.builder
        //       (
        //         itemCount: litems.length,
        //         itemBuilder: (BuildContext ctxt, index) {
        //           return new Text(litems[index]);
        //         }
        //     )
        // )
            

          ],
        );
      },
    );
  }
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        
        _isFavorited = false;
      } else {
        
        _isFavorited = true;
      }
    });
  }
  
}