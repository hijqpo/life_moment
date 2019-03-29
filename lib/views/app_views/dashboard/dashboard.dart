import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/services/auth_management.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/app_views/notification_view.dart';
import 'package:life_moment/views/app_views/profile_sub_views/user_friend_view.dart';
import 'package:life_moment/views/friend_profile_view.dart';
import 'dart:async';

// Views
import 'package:life_moment/views/app_views/dashboard/home_view.dart';
import 'package:life_moment/views/chart_view.dart';
import 'package:life_moment/views/app_views/dashboard/profile_view.dart';
import 'package:life_moment/widgets/app_bars/app_bar_builder.dart';
import 'package:life_moment/widgets/dashboard_search_bar.dart';
import 'package:life_moment/views/map_view.dart';

const List<String> Titles = [
  'Home',
  'Friend',
  'Map',
  'Notification',
  'Profile'
];

class Dashboard extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _DashboardState();
  }
}


class _DashboardState extends State<Dashboard> {


  static int _defaultIndex = 0;

  // String _title = Titles[_defaultIndex];
  int _selectedIndex = _defaultIndex;
  // Icon _currentEmojiIcon = Icon(Icons.mood);
  
  final _widgetOptions = [
    HomeView(),
    // FriendProfileView(),
    Text('Index 1: ??????'),
    MapView(),
    ChartView(),
    ProfileView(),
  ];

  _onNavItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      // title = Titles[_selectedIndex];
    });
  }


  void _onNotificationPressed(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationView()));
  }

  @override
  Widget build(BuildContext context) {
  
    int notificationCount = GlobalState.notificationCount;

    return Scaffold(

      appBar: AppBarBuilder.dashboardAppBar(_onNotificationPressed, notificationCount),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.orangeAccent
        ),
        child: BottomNavigationBar(

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.group), title: Text('Friend')),
            BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
            BottomNavigationBarItem(icon: Icon(Icons.insert_chart), title: Text('Chart')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.deepPurple,
          onTap: _onNavItemTapped,
        ),
      )
    );
  }
}


