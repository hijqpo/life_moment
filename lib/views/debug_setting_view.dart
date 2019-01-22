import 'package:flutter/material.dart';

class DebugSettingView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
      
      return _DebugSettingViewState();
    }

}

class _DebugSettingViewState extends State<DebugSettingView> {

  final _apiBaseUrlFieldController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Setting'),
      ),
      
      body: ListView(
      // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          
          ListTile(
            title: Text('API Base URL'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
            },

            
          ),

          



        ],
      )
    );
  }

}

