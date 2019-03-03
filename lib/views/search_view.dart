import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/factories.dart';
import 'package:life_moment/services/operation_management.dart';
import 'package:life_moment/services/user_management.dart';
import 'package:life_moment/widgets/dashboard_search_bar.dart';

class SearchView extends StatefulWidget {
  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {

  GlobalKey<SearchViewState> stateKey = GlobalKey();

  bool _loading = false;
  bool _showError = false;
  bool _showResult = false;

  String _errorMessage = '';
  String _keyword = '';


  void _onCancelPressed(){

    Navigator.pop(context);
  }

  void onSubmitted(String keyword) async{
    
    if (keyword == '') return;

    debugPrint('Submitted keyword: $keyword');

    setState(() {
      _loading = true;
    });
    
    OperationResponse response = await UserManagement.search(keyword:keyword);
    
    debugPrint(response.toString());

    if (response.isError){

      setState(() {
        _showError = true;
        _showResult = false;
        _errorMessage = response.message;
        _loading = false;
      });

    }
    else{
      setState(() {
        _showError = false;
        _showResult = true;
        _keyword = keyword;
        _loading = false;
      });
    }
  }

  void onClear(){

    setState(() {
        _showError = false;
        _showResult = false;
        //_keyword = keyword;
        _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: Size(0, 40),
        child:  AppBar(
          //leading: null,
          automaticallyImplyLeading: false,
          title: DashboardSearchBar(searchable: true, onSubmitted: onSubmitted, onClear: onClear,),

          centerTitle: false,
          actions: <Widget>[
            FlatButton(
              onPressed: _onCancelPressed,
              child: Text('Cancel', style:TextStyle(color: Colors.white)),
            )
          ],
        )
      ),
      body: Container(
        
        child: _loading
        // Case 1: Show loading when searching
        ? Center(child: CircularProgressIndicator())
        : Column(
          
          
          children: <Widget>[

            // Case 2: Show error message when there is error
            _showError 
            ? Text('$_errorMessage', style: TextStyle(color: Colors.red),) 
            : Container(),

            // Case 3: Show search result after searching, or show the search history before search
            _showResult
            ? Expanded(child: Column( 
              
              children: <Widget>[
                Row(

                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 12, bottom: 6, left: 12, right: 12),

                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.black))
                        ),
                        child: Text(
                          'Search result of [ $_keyword ]',
                          style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                        )
                      ),
                    ),
                      
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: WidgetFactory.searchResultListBuilder()
                  )
                )
              
              ]
            ))
            // Before Search
            : Expanded(child: Column( 
              
              children: <Widget>[

                Row(

                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 16, bottom: 6, left: 12, right: 12),

                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.black))
                        ),
                        child: Text(
                          'Recent search history',
                          style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                        )
                      ),
                    ),
                      
                  ],
                ),
                
                Expanded(
                  child: ListView(
                    children: <Widget>[]
                  )
                )
              
              ]
            ))
          ],  
          
        )
      ,)

    );
  }
}