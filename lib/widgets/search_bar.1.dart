import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final _searchFieldController = TextEditingController();

  String _keyword = '';

  void onSearchPressed() async {

    // _keyword = _searchFieldController.text;
    // if (_keyword == '') return;

    // Dashboard.of(context).updateLoadingState(true);
    // OperationResponse response = await DataManagement.getMembers(keyword: _keyword);

    // String message = '';

    // if (response.code == 21){
    //   // Found Result
    //   message = 'Search result of {$_keyword}: ${GlobalState.memberList.length} member(s) found';
    // }
    // else{
    //   // No Result
    //   message = 'Search result of {$_keyword}: 0 members found';
    // }

    // Dashboard.of(context).updateResultMessage(message);
    // Dashboard.of(context).updateLoadingState(false);
  }

  // void onSearchAllPressed() async {

  //   Dashboard.of(context).updateLoadingState(true);
  //   OperationResponse response = await DataManagement.getMembers();

  //   String message = '';

  //   if (response.code == 21){
  //     // Found Result
  //     message = 'All members: ${GlobalState.memberList.length} member(s) found';
  //   }
  //   else{
  //     // No Result
  //     message = 'All members: 0 members found';
  //   }

  //   Dashboard.of(context).updateResultMessage(message);
  //   Dashboard.of(context).updateLoadingState(false);

  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),

      child: Row(
        children:<Widget>[

          Icon(FontAwesomeIcons.sistrix),

          Expanded(
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 15),

              child: TextField(
                controller: _searchFieldController,
                
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                    
                ),
                style: TextStyle(
                  fontSize: 18
                )
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RaisedButton(
              onPressed: onSearchPressed,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Text('Search'),
              
            ),
          ),
        ]
      ),
    );
  }
}