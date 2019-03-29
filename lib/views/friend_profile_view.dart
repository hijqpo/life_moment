import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/operation_management.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';

// Widget

// data
import 'package:charts_flutter/flutter.dart';


class FriendProfileView extends StatefulWidget {

  FriendProfileView({@required this.profile});

  final UserProfile profile;
  //final Relationship relationship;

  @override
  State<StatefulWidget> createState() {
    return new _FriendProfileViewState();
  }
}

class _FriendProfileViewState extends State<FriendProfileView> {

  _FriendProfileViewState(){
    debugPrint('[Friend Profile] initializing...');

    // Load the mood and post data
  }


  bool chartAnimated = true;

  bool _friendOperationLoading = false;
  // bool loading

  Future<void> _load(){
    
  }

  Future<void> _onAddFriendPressed() async{

    debugPrint('[Friend Profile] Add Friend Pressed');
    OperationResponse response = await UserManagement.sendFriendRequest(receiverUserProfile: widget.profile);
    debugPrint('${response.toString()}');
    setState((){
      chartAnimated = false;
      widget.profile.relationship.status = 'sent_request';
      GlobalState.appendSearchResult(widget.profile);
    });
  }

  Future<void> _onAcceptFriendPressed() async{

    debugPrint('[Friend Profile] Accept Friend Pressed');
    // TODO: Send request
    setState((){
      chartAnimated = false;
      widget.profile.relationship.status = 'friend';
      GlobalState.appendSearchResult(widget.profile);
    });
  }




  @override
  Widget build(BuildContext context) {

    UserProfile profile = widget.profile;
    String nickname = profile.nickname;

    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: Size(0, 40),
        child: AppBar(

          title: Text(
            '$nickname\'s Profile',
            style: TextStyle(fontWeight: FontWeight.w500)
          ),
        ),
      ),

      body: Center(
        child: Column(
        
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            
            _buildProfile(),

            Divider(),

            _buildGiftStand(),

            Divider(),

            _buildMoodChart(),
              
            Divider(),

            _buildPostList(),

            Divider(),

          ]
        ),
      ) 
    );
  }



  Widget _buildProfile(){

    UserProfile profile = widget.profile;
    String _avatarURL = profile.avatarURL;
    String _nickname = profile.nickname;

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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

            //subtitle: _buildEditProfileButton(),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              
                Text(
                  '$_nickname',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.w500
                  )
                ),

                _buildFriendOperationWidget()
              ]
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildStatContainer(){

    UserProfile profile = widget.profile;

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
      onPressed: null,
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

  Widget _buildMoodChart(){

    final myFakeDesktopData = [
      // new MoodChartData(DateTime.utc(2019, 2, 1), 0, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 2), 1, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 3), 2, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 4), 3, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 5), 4, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 6), 2, 50),
      // new MoodChartData(DateTime.utc(2019, 2, 7), 3, 50),
    ];


    if (myFakeDesktopData.length == 0){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'No Mood Progress',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16
              )
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0),),
            Icon(
              Icons.sentiment_dissatisfied
            )

          ],
        )
        
        
        
        
      );
    }

    List<Series<MoodChartData, DateTime>> chartData = [

      Series<MoodChartData, DateTime>(
        id: 'Mood',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (MoodChartData mood, _) => mood.time,
        measureFn: (MoodChartData mood, _) => mood.moodType,
        data: myFakeDesktopData,
        fillColorFn: (_, __) => MaterialPalette.green.shadeDefault,
        radiusPxFn: (MoodChartData mood, __) => 3 + (mood.moodIntensity / 30)
      )
    ];


    return  Container(
      height: 130,
      child: TimeSeriesChart(
        chartData, 
        animate: chartAnimated, 
        defaultRenderer: LineRendererConfig(includePoints: true),
        domainAxis: DateTimeAxisSpec(
          showAxisLine: true, 
          tickFormatterSpec: AutoDateTimeTickFormatterSpec(
            day: TimeFormatterSpec(
              format: 'dd',
              transitionFormat: 'dd MM'
            )
          )
        ),
      )
    );
  }
  
  Widget _buildFriendOperationWidget(){

    UserProfile profile = widget.profile;
    var status = profile.relationship.status;

    // Handle Exception situation
    if (status == null || status == 'unknown'){
      debugPrint('[Friend Profile] No Relationship data found - Disabled friend operation');
      return 
        Column(
          children: <Widget>[
            Icon( Icons.person_add,),
            Text('<Disabled>', style: TextStyle(color: Colors.red))
          ],
        );
    }

    if (status == 'stranger'){
      return 
        FlatButton(
          onPressed: _onAddFriendPressed,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_add,
              ),
              Text('Add Friend')
            ],
          )
        );
    }

    if (status == 'friend'){
      return 
        Column(
          children: <Widget>[
            Icon(
              Icons.person,
              color: Colors.blue[300]
            ),
            Text('Friend')
          ],
        );
    }

    if (status ==  'sent_request'){
      return 
        Column(
          children: <Widget>[
            Icon(
              Icons.send,
              color: Colors.blue
            ),
            Text('Friend Request Sent')
          ],
        );
    }

    if (status == 'received_request'){
      return 
        FlatButton(
          onPressed: _onAcceptFriendPressed,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.done,
              ),
              Text('Accept Friend Request')
            ],
          )
        );
    }

    return Container();
  }

  Widget _buildPostList(){

    if (GlobalState.userPostDataList.length == 0){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No Posts',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16
          )
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: <Widget>[

          Text('hahah'),


        ],
      ),
    );
  }

  Widget _buildGiftStand(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'No Gift Stand',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16
        )
      ),
    );
  }

}


