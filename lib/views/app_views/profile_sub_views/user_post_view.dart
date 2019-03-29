import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/widgets/app_bars/app_bar_builder.dart';

class UserPostView extends StatefulWidget {

  UserPostView(this.userProfile);

  final UserProfile userProfile;

  @override
  _UserPostViewState createState() => _UserPostViewState();
}

class _UserPostViewState extends State<UserPostView> {

  @override
  Widget build(BuildContext context) {

    String nickname = widget.userProfile.nickname;

    return Scaffold(
      
      appBar: AppBarBuilder.titledAppBar('$nickname\'s posts'),
      body: Center(

        child: _buildPostList()
      )
    );
  }


  Widget _buildPostList(){
    
    


    return Container();
  }

}