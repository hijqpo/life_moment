import 'package:flutter/material.dart';
//import 'package:life_moment/services/stream_widget.dart';
//import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';
import 'package:fcharts/fcharts.dart';


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

String _fullName = GlobalState.userProfile.nickname;
String _friends = "173";
String _posts = "24";
String _scores = "450";
String _bio = "Hello, I am a surprised cat. Meow";
String _education = "The University of Hong Kong";
String _dob = "15 Feb 2019";
//final StorageReference ref = FirebaseStorage.instance.ref().child('users/assets/images/cat.jpeg');
//final Uri downloadUrl = await ref.getDownloadUrl();

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
            image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/life-moment-89403.appspot.com/o/profile_pics%2Fcat.jpeg?alt=media&token=c2bab624-8fb8-4089-b7a5-54aff38644b6'),
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

Widget _buildStatItem(String label, String count, BuildContext context) {
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

  return GestureDetector(
    onTap: (){
      final snackBar = SnackBar(content: Text("Tap"));

      Scaffold.of(context).showSnackBar(snackBar);
    },
    child: Column(
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
    ),
  );
}

Widget _buildStatContainer(BuildContext context) {
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
        _buildStatItem("Friends", _friends, context),
        _buildStatItem("Posts", _posts, context),
        _buildStatItem("Scores", _scores, context),
      ],
    ),
  );
}

Widget _buildBio(BuildContext context) {
  TextStyle bioTextStyle = TextStyle(
    fontFamily: 'Spectral',
    fontWeight: FontWeight.w400,
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
        "'$_bio'",
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    ),
  );
}

Widget _buildSeparator(Size screenSize) {
  return Container(
    alignment: Alignment(0.0, 0.28),
    child: Container(
      width: screenSize.width / 1.3,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    ),
  );
}

Widget _buildDob(BuildContext context){
  return Container(
    alignment: Alignment(-0.9, 0.4),
      child: ListTile(
        leading: Icon(Icons.cake),
        title: Text('Birthday: $_dob'),
      ),
  );
}

Widget _buildEdu(BuildContext context){
  return Container(
    alignment: Alignment(-0.9, 0.5),
      child: ListTile(
        leading: Icon(Icons.school),
        title: Text('Education: $_education'),
      ),
  );
}

const data = [0.0, -0.2, -0.9, -0.5, 0.0, 0.5, 0.6, 0.9, 0.8, 1.2, 0.5, 0.0];
Widget _buildChart(){
  return Container(
    alignment: Alignment(0.0, -0.9),
    
    child: AspectRatio(
      aspectRatio: 4.0,
      child: new LineChart(
        lines: [
          Sparkline(
            data: data,
            stroke: new PaintOptions.stroke(
              color: Colors.green,
              strokeWidth: 2.0,
            ),
            marker: new MarkerOptions(
              paint: new PaintOptions.fill(color: Colors.red),
            ),
          ),
          Sparkline(
            data: data,
            stroke: new PaintOptions.stroke(
              color: Colors.blue,
              strokeWidth: 2.0,
            ),
            marker: new MarkerOptions(
              paint: new PaintOptions.fill(color: Colors.red),
            ),
          ),
          
        ],
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
          //_buildCoverImage(screenSize),
          Text('Mood Progress',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          _buildChart(),
          _buildProfileImage(),
          _buildName(),
          _buildStatContainer(context),
          _buildBio(context),
          _buildDob(context),
          _buildSeparator(screenSize),
          _buildEdu(context),
          

        ],
      )
    );
  }
}