import 'package:flutter/material.dart';
import 'package:life_moment/services/stream_widget.dart';
import 'package:life_moment/state.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(GlobalState.userProfile.data['nickname']));
  }
}