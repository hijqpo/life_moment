import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/notification_data.dart';

class NotificationCell extends StatefulWidget {

  NotificationCell(this.data);
  
  final NotificationData data;

  @override
  _NotificationCellState createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {


  @override
  void initState(){
    super.initState();
    _type = widget.data.type;
    _detail = widget.data.detail;
    _read = widget.data.read;

    _avatarURL = widget.data.avatarURL;
  }

  String _type;
  String _detail;
  bool _read;
  String _avatarURL;

  void _onPostNotificationPressed(){

  }

  void _onAcceptFriendPressed(){

  }

  void _onRejectFriendPressed(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: _buildContent()
    );
  }


  Widget _buildContent(){

    Color backgroundColor = Colors.white;

    if (!_read){
      backgroundColor = Colors.lightBlue[100];
    }

    if (_type == 'post'){

      // Post related notification
      return Container(

        //padding: const EdgeInsets.all(12.0),
        color: backgroundColor,

        child: _buildPostContent()
      );

    }

    return Container();
  }

  Widget _buildPostContent(){

    String nickname1 = widget.data.nickname1;
    String nickname2 = widget.data.nickname2;
    String nickname3 = widget.data.nickname3;
    // int commentUserCount = widget.data.
    
    return FlatButton(

      padding: const EdgeInsets.all(0),
      onPressed: _onPostNotificationPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[

            Row(
              children: <Widget>[

                CircleAvatar(
                  backgroundImage: NetworkImage(
                    _avatarURL
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Text(
                  'This is post notifications',
                  style: TextStyle()
              ),


              ],
            ),

          ],
        ),
      )
    );
  }
}