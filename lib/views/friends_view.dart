import 'package:flutter/material.dart';


// Widget
import 'package:life_moment/widgets/news_feed/news_feed.dart';

import 'package:material_search/material_search.dart';

// data
import 'package:life_moment/data_structures/news_feed_data.dart';

class FriendView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _FriendViewState();
  }
}



class _FriendViewState extends State<FriendView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[

        MaterialSearch<String>(
          placeholder: 'Search',

          getResults: (String criteria) async {
            
            return [
              MaterialSearchResult(value: 'A'),
              MaterialSearchResult(value: 'B'),
              MaterialSearchResult(value: 'C'),
            ]; 

          }
        ),
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


