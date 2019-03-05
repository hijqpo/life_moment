import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/auth_management.dart';
import 'package:life_moment/services/user_management.dart';

import 'package:life_moment/state.dart';
import 'package:life_moment/views/edit_profile_view.dart';


class ProfileView extends StatefulWidget {

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  bool chartAnimated = true;
  RelationshipStatus currentRelationshipStatus;


  void _onSignOutPressed(){

    AuthManagement.signOut();
  }

  void _onEditProfilePressed(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditProfileView()));
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

    final myFakeDesktopData = [
      new LinearSales(0, 0),
      new LinearSales(1, 25),
      new LinearSales(2, 75),
      new LinearSales(3, 75),
      new LinearSales(4, 100),
      new LinearSales(5, 50),
      new LinearSales(6, 75),
    ];

    List<Series<LinearSales, int>> chartData = [

      Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
        fillColorFn: (_, __) => MaterialPalette.green.shadeDefault,
        radiusPxFn: (_, __) => 3
      )
    ];

    return ExpansionTile(

      title: Text(
        'Mood Progress',
        style: TextStyle(
          fontWeight: FontWeight.w700
        )
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(12),
          height: 120,
          child: LineChart(
            chartData, 
            animate: chartAnimated, 
            defaultRenderer: LineRendererConfig(includePoints: true), 
            domainAxis: NumericAxisSpec(
              showAxisLine: true, 
              renderSpec: NoneRenderSpec()
            ),
          )
        ),
      ],

    );
    
  }

  Widget _buildProfile(){

    UserProfile profile = GlobalState.userProfile;
    String _avatarURL = profile.avatarURL;
    String _nickname = profile.nickname;

    return Container(

      padding: const EdgeInsets.all(8),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[ 
          
          ListTile(

            leading: CircleAvatar(
              backgroundImage: NetworkImage(_avatarURL),
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
              '$_nickname',
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
        _buildStatItem(label: 'Posts', count: profile.postCount.toString()),
        _buildStatItem(label: 'Score', count: profile.score.toString())
      ],
    );
  }

  Widget _buildStatItem({String label, String count}){

    return FlatButton(
      onPressed: (){},
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

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

