import 'package:flutter/material.dart';
import 'package:life_moment/services/operation_management.dart';

import 'package:life_moment/views/search_view.dart';
import 'package:life_moment/widgets/router_widgets.dart';


class DashboardSearchBar extends StatefulWidget {

  DashboardSearchBar({this.searchable = false, this.onSubmitted, this.onClear});
  final bool searchable;
  // final GlobalKey<SearchViewState> key;
  final void Function(String) onSubmitted;
  final void Function() onClear;


  @override
  State<StatefulWidget> createState() {

    return _DashboardSearchBarState();
  }
}

class _DashboardSearchBarState extends State<DashboardSearchBar> {

  final _searchFieldController = TextEditingController();
  final _focusNode = FocusNode();

  _DashboardSearchBarState(){
    // if (widget.searchable){
    //   FocusScope.of(context).autofocus(_focusNode);
    // }
    //
  }

  void onPressed(){

    Navigator.push(context, SlidePageRoute(widget: SearchView(), offset: SlideDirection.up));
  }

  void onClearPressed(){
    _searchFieldController.text = '';

    if (widget.onClear != null){
      widget.onClear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      //color: Colors.red,
      padding: EdgeInsets.all(0),
      onPressed: widget.searchable ? null : onPressed,
      child: Container(

        // This Control the height of the child container
        margin: const EdgeInsets.symmetric(vertical: 6),
        //height: 28,

        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(50)
        ),

        // child: Expanded(
          
        child: TextField(
          
          controller: _searchFieldController,
          enabled: widget.searchable,
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top:4),
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search, size:20),
            
            //fillColor: Colors.yellow,
            //filled: true,
            suffixIcon: widget.searchable 
              ? IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.cancel,
                  size: 20,
                ),
                onPressed: onClearPressed
              )
              : null,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSubmitted,
          style: TextStyle(fontSize: 16)
        ),
        //),
      ),
    );
  }
}