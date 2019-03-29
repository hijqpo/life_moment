import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/widgets/app_bars/app_bar_builder.dart';
import 'package:life_moment/widgets/error_text.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  UserProfile _userProfile;
  String _errorMessage = '';

  @override
  void initState(){
    super.initState();
    _userProfile = GlobalState.userProfile;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarBuilder.titledAppBar('Notifications'),
      body: Center(
        child: Column(
          children: <Widget>[

            _buildErrorText(_errorMessage),
            Divider(),
            _buildNotificationList(),

          ]
        )
      )
    );
  }


  Widget _buildErrorText(String message){

    return ErrorText(message);
  }

  Widget _buildNotificationList() {

    return Expanded(
      
      child: ListView(

        semanticChildCount: 10,
        children: WidgetFactory.notificationListBuilder()
      )
    );
  }


}