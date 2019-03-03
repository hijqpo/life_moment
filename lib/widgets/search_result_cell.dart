import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/friend_profile_view.dart';

class SearchResultCell extends StatefulWidget {

  SearchResultCell({@required this.data});

  final UserProfile data;

  @override
  _SearchResultCellState createState() => _SearchResultCellState();
}

class _SearchResultCellState extends State<SearchResultCell> {

  void _onCellPressed(){
    debugPrint('User cell is pressed');

    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendProfileView(profile: widget.data)));
  }

  @override
  Widget build(BuildContext context) {

    UserProfile data = widget.data;
    bool emptyCell = false;
    if (data == null) emptyCell = true;

    String photoURL = data.avatarURL == null ? UserProfile.defaultAvatarURL : data.avatarURL;
    String nickname = data.nickname == null ? '' : data.nickname;
    // String nickname = data.nickname == null ? '' : data.nickname;

    return Container(
      
      child: Card(

        child: emptyCell
        ? Text('This is empty cell')
        : FlatButton(
          padding: const EdgeInsets.all(0),
          onPressed: _onCellPressed,
          child:Column(
            children: <Widget>[

              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(photoURL)
                ),
                title: Text('$nickname'),
              )
            ],
          ),
        )
      )

    );
  }
}