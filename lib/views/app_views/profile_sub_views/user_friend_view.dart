import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/widgets/app_bars/app_bar_builder.dart';

class UserFriendView extends StatefulWidget {

  UserFriendView(this.userProfile);

  final UserProfile userProfile;

  @override
  _UserFriendViewState createState() => _UserFriendViewState();
}

class _UserFriendViewState extends State<UserFriendView> {

  @override
  Widget build(BuildContext context) {

    String nickname = widget.userProfile.nickname;

    return Scaffold(
      
      appBar: AppBarBuilder.titledAppBar('$nickname\'s Friends'),
      body: Center(

        child: Text('testing...')

      )
    );
  }
}