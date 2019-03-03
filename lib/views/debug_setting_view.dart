import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/operation_management.dart';

class DebugSettingView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
      
      return _DebugSettingViewState();
    }

}

class _DebugSettingViewState extends State<DebugSettingView> {

  final _apiBaseUrlFieldController = TextEditingController();


  Future<void> onExceptionTestPressed() async{

    OperationResponse result = await OperationManagement.exceptionPlayground();
  }

  Future<void> onClearAllPostsPressed() async{

    OperationResponse result = await OperationManagement.clearAllPosts();
  }


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
            }
          ),

          ListTile(
            title: Text('Clear All Posts'),
            onTap: onClearAllPostsPressed
          ),

          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
            }
          ),

          



        ],
      )
    );
  }

}

