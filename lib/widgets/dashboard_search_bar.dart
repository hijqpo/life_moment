import 'package:flutter/material.dart';

import 'package:life_moment/views/search_view.dart';
import 'package:life_moment/widgets/router_widgets.dart';


class DashboardSearchBar extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {

    return _DashboardSearchBarState();
  }
}

class _DashboardSearchBarState extends State<DashboardSearchBar> {

  final _searchFieldController = TextEditingController();

  void onPressed(){

    Navigator.push(context, SlidePageRoute(widget: SearchView(), offset: SlideDirection.up));
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(

        // This Control the height of the child container
        margin: const EdgeInsets.symmetric(vertical: 10),
        //height: 28,

        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(50)
        ),

        // child: Expanded(
          child: TextField(
            
            controller: _searchFieldController,
            enabled: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search)
            ),

          ),
        //),
      ),
    );
  }
}