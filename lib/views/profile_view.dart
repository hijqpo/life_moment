import 'package:flutter/material.dart';
import 'package:life_moment/services/user_management.dart';



class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return UserManagement.userProfile();
  }
}