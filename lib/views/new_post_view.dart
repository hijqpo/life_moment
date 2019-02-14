import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:life_moment/forms/new_post_form.dart';


class NewPostView extends StatefulWidget {
  @override
  _NewPostViewState createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {

  final GlobalKey<NewPostFormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('New Mood Post', style: TextStyle(fontWeight: FontWeight.w600),),
        actions: <Widget>[

          IconButton(
            onPressed: (){
              formKey.currentState.onSubmit();
            },
            icon: Icon(Icons.send)  
          )
        ],
      ),
      body: Center(
        
        child: NewPostForm(key: formKey)
      ),
    );
  }
}