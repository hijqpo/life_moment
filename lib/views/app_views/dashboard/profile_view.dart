import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/auth_management.dart';
import 'package:life_moment/services/user_management.dart';

import 'package:life_moment/state.dart';
import 'package:life_moment/views/app_views/profile_sub_views/edit_profile_view.dart';
import 'package:life_moment/views/app_views/profile_sub_views/user_friend_view.dart';
import 'package:life_moment/views/app_views/profile_sub_views/user_post_view.dart';

import 'package:life_moment/views/structure.dart';
import 'package:life_moment/widgets/charts/mood_progress.dart';


class ProfileView extends StatefulWidget {

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool _chartAnimated = true;
  RelationshipStatus currentRelationshipStatus;


  String _errorMessage = '';

  bool _moodLoading = true;
  List<MoodChartData> _moodData;

  UserProfile _userProfile;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProfile = GlobalState.userProfile;
    _initialRefresh();
  }

  Future<void> _initialRefresh() async {

    if (this.mounted){
      setState(() {
        _moodLoading = true;
      });
    }

    OperationResponse response = await UserManagement.loadUserMood(_userProfile.uid);

    if (response.isError && this.mounted){

      setState(() {
        _moodLoading = false;
        _errorMessage = response.message;
      });
    }
    else{

      if (this.mounted) {
        setState(() {
          _moodLoading = false;
          _errorMessage = '';
          _moodData = response.data;
        });
      }
    }
  }

  void _onSignOutPressed(){

    AuthManagement.signOut();
  }

  void _onEditProfilePressed(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditProfileView()));
  
    //Navigator.of(context).pu
  }

  void _onPostsPressed(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserPostView(_userProfile)));
  }

  void _onFriendsPressed(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserFriendView(_userProfile)));
  }

  Future<void> _onRefresh(){

    //setState((){});
    //setState((){Scaffold.of(context).setState((){});});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      
      child: Column(
        children: <Widget>[

          _buildProfile(),

          Divider(height: 0,),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                
                children: <Widget>[
                 _buildMoodChart(),
                ],
              )
            ),
          ),
         
          // _buildBasicProfile(),

          Divider(height: 0),
          _buildSignOutButton(),
          // _buildStatContainer(),

        ],
      )
    );
  }

  Widget _buildMoodChart(){

    Widget chart;
    if (_moodLoading) {
      chart = Text('Loading...');
    }
    else{
      chart = MoodProgress(_moodData);
    }

    return ExpansionTile(

      title: Text(
        'Mood Progress',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700
        )
      ),
      children: <Widget>[
        chart
      ],
    );
  }

  Widget _buildProfile(){

    UserProfile profile = GlobalState.userProfile;
    String avatarURL = profile.avatarURL;
    String nickname = profile.nickname;

    return Container(

      padding: const EdgeInsets.all(8),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[ 
          
          ListTile(

            leading: CircleAvatar(
              backgroundImage: NetworkImage(avatarURL),
              radius: 40,
            ),

            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: _buildStatContainer(),
            ),

            subtitle: _buildEditProfileButton(),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10),
            child: Text(
              '$nickname',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.w500
              )
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildStatContainer(){

    UserProfile profile = GlobalState.userProfile;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        _buildStatItem(label: 'Friends', count: profile.friendCount.toString()),
        _buildStatItem(label: 'Posts', count: profile.postCount.toString(), onPressed: _onPostsPressed),
        _buildStatItem(label: 'Score', count: profile.score.toString(), onPressed: _onFriendsPressed)
      ],
    );
  }

  Widget _buildStatItem({String label, String count, Function() onPressed}){

    return FlatButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black54
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black54
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelationship(){

  }

  Widget _buildSignOutButton(){

    return FlatButton(  
      onPressed: _onSignOutPressed,
      child: Row(

        children: <Widget>[

          Icon(
            FontAwesomeIcons.signOutAlt
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8),),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                )
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildEditProfileButton(){

    return Row(

      children: <Widget>[
        Expanded(
          child: Container(
            
            height: 30,
            margin: const EdgeInsets.only(top: 8),
            // padding: const EdgeInsets.all(0),
            // color: Colors.black38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black45)
            ),
            
            child: FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: _onEditProfilePressed,

              child: Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
            ),
          )
        ),
      ]
    );
  }
}