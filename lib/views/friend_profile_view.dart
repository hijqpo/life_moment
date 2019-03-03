import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/friend_data.dart';
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



  RelationshipStatus currentRelationshipStatus;
  bool chartAnimated = true;
  // bool loading

  Future<void> _onAddFriendPressed() async{

    debugPrint('[Friend Profile] Add Friend Pressed');
    OperationResponse response = await UserManagement.sendFriendRequest(receiverUserProfile: widget.profile);
    debugPrint('${response.toString()}');
    setState((){
      chartAnimated = false;
      currentRelationshipStatus = RelationshipStatus.SentRequest;
    });
  }

  void _onAcceptFriendPressed(){

    debugPrint('[Friend Profile] Accept Friend Pressed');
    setState((){
      chartAnimated = false;
      currentRelationshipStatus = RelationshipStatus.Friend;
    });
  }



  Widget buildFriendOperationWidget(){

    // Handle Exception situation
    if (currentRelationshipStatus == null || currentRelationshipStatus == RelationshipStatus.Unknown){
      debugPrint('[Friend Profile] No Relationship data found - Disabled friend operation');
      return 
        Column(
          children: <Widget>[
            Icon( Icons.person_add,),
            Text('<Disabled>', style: TextStyle(color: Colors.red))
          ],
        );
    }

    if (currentRelationshipStatus == RelationshipStatus.Stranger){
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

    if (currentRelationshipStatus == RelationshipStatus.Friend){
      return 
        FlatButton(
          onPressed: (){},
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.blue[300]
              ),
              Text('Friend')
            ],
          )
        );
    }

    if (currentRelationshipStatus == RelationshipStatus.SentRequest){
      return 
        FlatButton(
          // TODO: Add remove 
          onPressed: (){},
          child: Column(
            children: <Widget>[
              Icon(
                Icons.send,
                color: Colors.blue
              ),
              Text('Friend Request Sent')
            ],
          )
        );
    }

    if (currentRelationshipStatus == RelationshipStatus.ReceivedRequest){
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




  @override
  Widget build(BuildContext context) {

    UserProfile profile = widget.profile;
    String nickname = profile.nickname;
    String photoURL = profile.avatarURL;

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

      body: Container(

        padding: const EdgeInsets.all(20),

        child: Center(

          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[

              Stack(
                children: <Widget>[

                  Container(
                    height: 130,
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
                  

                  Positioned (
                    
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 1.8,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(photoURL),
                            radius: 48,
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 6),),
                          Text(
                                '$nickname',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)
                              ),

                        ]
                      )
                    )
                  ),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  buildFriendOperationWidget()
                ]
              ),
   

            ]
          ),
        ),
      ) 
    );
  }



  
}





class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

