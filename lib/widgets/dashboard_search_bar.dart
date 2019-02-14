import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DashboardSearchBar extends StatelessWidget {

  final _searchFieldController = TextEditingController();

  void onPressed(){

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