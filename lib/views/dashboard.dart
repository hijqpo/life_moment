import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/services/auth_management.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/views/friend_profile_view.dart';
import 'dart:async';

// Views
import 'package:life_moment/views/home_view.dart';
import 'package:life_moment/views/chart_view.dart';
import 'package:life_moment/views/profile_view.dart';
import 'package:life_moment/widgets/dashboard_search_bar.dart';


const List<String> Titles = [
  'Home',
  'Friend',
  'Life Moment',
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
    Text('Index 2: Life Moment'),
    ChartView(),
    ProfileView(profile: GlobalState.userProfile),
  ];

  _onNavItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      // title = Titles[_selectedIndex];
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size(0, 40),
        child:  AppBar(
          title: DashboardSearchBar(),

          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,  
            ),
            tooltip: 'Sign out',
            onPressed: AuthManagement.signOut,
          ),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              tooltip: 'Notifications',
              onPressed: (){},
            )
          ],
        )
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      // body: Center(
      //   child: Stack(
      //     children: <Widget>[
      //       Offstage(
      //         offstage: _selectedIndex != 0,
      //         child: HomeView()
      //       ),
      //       Offstage(
      //         offstage: _selectedIndex != 1,
      //         child: Text('Index 1: ??????'),
      //       ),
      //       Offstage(
      //         offstage: _selectedIndex != 2,
      //         child: Text('Index 2: Life Moment'),
      //       ),
      //       Offstage(
      //         offstage: _selectedIndex != 3,
      //         child: ChartView(),
      //       ),
      //       Offstage(
      //         offstage: _selectedIndex != 4,
      //         child: ProfileView(),
      //       ),

      //     ]
      //   ),
      // ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.orangeAccent
        ),
        child: BottomNavigationBar(

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.group), title: Text('Friend')),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text('Life Moment')),
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


