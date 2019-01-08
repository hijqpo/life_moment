import 'package:flutter/material.dart';


// Widget
import 'package:life_moment/widgets/news_feed.dart';

// data
import 'package:life_moment/data/news_feed_data.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _HomeViewState();
  }
}



class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[

        Expanded(
          child: ListView(

            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            
            children: <Widget>[

              
            ],  
          )
        ),
      ]
    ); 
  }
}


