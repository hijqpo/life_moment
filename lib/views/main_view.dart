import 'package:flutter/material.dart';
import 'package:life_moment/state.dart';
import 'dart:async';

// Views
import 'package:life_moment/views/home_view.dart';


const List<String> Titles = [
  'Home',
  'Friend',
  'Life Moment',
  'Notification',
  'Profile'
];




class MainView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MainViewState();
  }

}



class MainViewState extends State<MainView> {

  MainViewState() {
    GlobalState.mainViewState = this;
  }

  static int _defaultIndex = 0;

  String _title = Titles[_defaultIndex];
  int _selectedIndex = _defaultIndex;
  Icon _currentEmojiIcon = Icon(Icons.mood);
  
  final _widgetOptions = [
    HomeView(),
    Text('Index 1: Friend'),
    Text('Index 2: Life Moment'),
    Text('Index 3: Notification'),
    Text('Index 4: Profile'),
  ];



  _onNavItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      _title = Titles[_selectedIndex];
    });
  }

  _onMoodIconPressed() {

    debugPrint('Mood is pressed');
    _changeMood();
  }

  Future<void> _changeMood() async {
    switch (await showDialog<Mood>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('What is your current mood?'),
          children: <Widget>[

            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, Mood.VeryHappy); },
              child: const Text('Very Happy'),
            ),

            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, Mood.Happy); },
              child: const Text('Happy'),
            ),

            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, Mood.Normal); },
              child: const Text('Normal'),
            ),

            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, Mood.Sad); },
              child: const Text('Sad'),
            ),

            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, Mood.VerySad); },
              child: const Text('Very Sad'),
            ),


          ],
        );
      }
    )) {

      case Mood.VeryHappy:
        // Let's go.
        debugPrint('The user is now very happy');
        GlobalState.updateCurrentMood(Mood.Happy);
        break;

      case Mood.Happy:
        // Let's go.
        debugPrint('The user is now happy');
        GlobalState.updateCurrentMood(Mood.Happy);
        break;

      case Mood.Normal:

        debugPrint('The user is now normal');
        GlobalState.updateCurrentMood(Mood.Normal);
        break;

      case Mood.Sad:
        debugPrint('The user is now sad');
        GlobalState.updateCurrentMood(Mood.Sad);
        break;

      case Mood.VerySad:
        // Let's go.
        debugPrint('The user is now very sad');
        GlobalState.updateCurrentMood(Mood.VerySad);
        break;
    }
  }

  void updateMood(Mood mood){

    setState(() {
      switch (mood){

        case Mood.VeryHappy:
          _currentEmojiIcon = Icon(Icons.mood);
          break;

        case Mood.Happy:
          _currentEmojiIcon = Icon(Icons.mood);
          break;

        case Mood.Normal:
          _currentEmojiIcon = Icon(Icons.sentiment_neutral);
          break;

        case Mood.Sad:
          _currentEmojiIcon = Icon(Icons.mood_bad);
          break;

        case Mood.VerySad:
          _currentEmojiIcon = Icon(Icons.mood);
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      appBar: AppBar(
        title: Text(_title),
        // Emoji Icon
        leading: IconButton(
          icon: _currentEmojiIcon,
          tooltip: 'Click this to change your mood',
          onPressed: _onMoodIconPressed,

        ),
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


