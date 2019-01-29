import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[

        Container(
          color: Colors.red, 
          height: 100.0,),

        Expanded(child: Row(children: <Widget>[

          Container(color: Colors.green, width: 100),
          Expanded(child: Container(color: Colors.blue,)),
          Container(color: Colors.green, width: 100),


        ],))


      ],
      
      
    );

        
      
  }
}