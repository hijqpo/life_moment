import 'package:flutter/material.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/state.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}
String _fullName = GlobalState.userProfile.data['nickname'];
String _followers = "173";
String _posts = "24";
String _scores = "450";
String _bio = "Hello, I am a surprised cat. Meow";

Widget _buildCoverImage(Size screenSize) {
  return Container(
    height: screenSize.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
}

Widget _buildProfileImage() {
  return Container(
    alignment: Alignment(0.0, -0.5),
    child: Container(
      width: 140.0,
      height: 140.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cat.jpeg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(80.0),
        border: Border.all(
          color: Colors.white,
          width: 10.0,
        ),
      ),
    ),
  );
}

Widget _buildName(){
  return Container(
    alignment: Alignment(0.0, -0.15),
    child: Text(
      _fullName,
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    ), 
  );
}

Widget _buildStatItem(String label, String count) {
  TextStyle _statLabelTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w200,
  );

  TextStyle _statCountTextStyle = TextStyle(
    color: Colors.black54,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        count,
        style: _statCountTextStyle,
      ),
      Text(
        label,
        style: _statLabelTextStyle,
      ),
    ],
  );
}

Widget _buildStatContainer() {
  return Container(
    //alignment: Alignment(0.0, -0.5),
    height: 60.0,
    margin: EdgeInsets.only(top: 330.0),
    decoration: BoxDecoration(
      color: Color(0xFFEFF4F7),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildStatItem("Followers", _followers),
        _buildStatItem("Posts", _posts),
        _buildStatItem("Scores", _scores),
      ],
    ),
  );
}

Widget _buildBio(BuildContext context) {
  TextStyle bioTextStyle = TextStyle(
    fontFamily: 'Spectral',
    fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
    fontStyle: FontStyle.italic,
    color: Color(0xFF799497),
    fontSize: 16.0,
  );
  
  return Container(
    alignment: Alignment(0.0, 0.4),
    child: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      //padding: EdgeInsets.all(8.0),
      
      height: 100,
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    ),
  );
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          _buildProfileImage(),
          _buildName(),
          _buildStatContainer(),
          _buildBio(context),
          
        ],
      )
    );
  }
}