import 'package:flutter/material.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';
import 'dart:async';

// Views
import 'package:life_moment/views/home_view.dart';
import 'package:life_moment/views/notification_view.dart';
import 'package:life_moment/views/profile_view.dart';


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

  String _title = Titles[_defaultIndex];
  int _selectedIndex = _defaultIndex;
  Icon _currentEmojiIcon = Icon(Icons.mood);
  
  final _widgetOptions = [
    HomeView(),
    Text('Index 1: Friend'),
    Text('Index 2: Life Moment'),
    NotificationView(),
    ProfileView(),
  ];



  _onNavItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      _title = Titles[_selectedIndex];
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      appBar: AppBar(
        title: Text(_title),
        // Emoji Icon

        // leading: IconButton(
        //   icon: _currentEmojiIcon,
        //   tooltip: 'Click this to change your mood',
        //   onPressed: null,
        // ),

        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.cancel),
          tooltip: 'Sign Out',
          onPressed: UserManagement.signOut,

        ),

        ],
      ),
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
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text('Life Moment')),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Text('Notifications')),
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

