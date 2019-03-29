import 'package:flutter/material.dart';
import 'package:life_moment/widgets/dashboard_search_bar.dart';


class AppBarBuilder {

  static PreferredSizeWidget dashboardAppBar(Function() onNotificationPressed, int notificationCount){
    return PreferredSize(
      preferredSize: Size(0, 40),
      child: AppBar(
        title: DashboardSearchBar(),

        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                tooltip: 'Notifications',
                onPressed: onNotificationPressed,
              ),

              notificationCount == 0
              ? Container()
              : Positioned(
                right: 5,
                child: Container(
                  
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    
                  ),
                  child: Center(
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        fontSize: 10
                      )
                    )
                  )

                )
              )
            ],
          )
          
        ],
      )
    );
  }

  static PreferredSizeWidget titledAppBar(String title){
    return PreferredSize(
      preferredSize: Size(0, 40),
      child: AppBar(
        title: Text(
          '$title',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.0
          )
        ),
      )
    );
  }


  
}


