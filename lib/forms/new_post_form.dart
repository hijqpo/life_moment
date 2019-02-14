import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/forms/form_widgets/form_section.dart';
import 'package:life_moment/services/data_management.dart';
import 'package:life_moment/state.dart';




class NewPostForm extends StatefulWidget {

  NewPostForm({Key key}) : super(key: key);

  @override
  NewPostFormState createState() => NewPostFormState();
}

class NewPostFormState extends State<NewPostForm> {


  final _descriptionFieldController = TextEditingController();
  final _descriptionFieldFocusNode = FocusNode();

  String _failSubmitPostMessage = '';
  String _emptyMoodWarningMessage = '';

  Mood _currentMood = Mood();

  Map<MoodType, Color> moodColorMap = {

    MoodType.VeryUnhappy: Colors.red,
    MoodType.Unhappy: Colors.red[200],
    MoodType.Neutral: Colors.white,
    MoodType.Happy: Colors.yellow[200],
    MoodType.VeryHappy: Colors.yellow,
  };

  void onMoodSelected(int typeCode){

    clearFieldFocus();

    setState((){
      _currentMood.moodTypeCode = typeCode;
      _emptyMoodWarningMessage = '';
    });
  }

  void onIntensityChanged(int val){

    clearFieldFocus();

    setState(() {
      _currentMood.intensity = val;
    });
  }

  // void setLoadingState(bool state){
    
  //   setState((){
  //     _isLoading = state;
  //   });
  // }

  Color currentBackgroundColor(){

    if (_currentMood == null) return Colors.white;
    // if (moodColorMap == null) return Colors.white;

    double lerp = (_currentMood.intensity.toDouble() / 200); 
    if (lerp >= 0.5) lerp = 0.5;
    if (lerp <= 0) lerp = 0;


    return moodColorMap[_currentMood.moodType] == null 
      ? Colors.white 
      : moodColorMap[_currentMood.moodType].withOpacity(0.5 + lerp);
  }

  void clearFieldFocus(){
    if (_descriptionFieldFocusNode.hasFocus){
      _descriptionFieldFocusNode.unfocus();
    }
  }

  void onSubmit() async{

    debugPrint('Submit is pressed');

    clearFieldFocus();

    if (_currentMood.moodType == null){
      setState((){
        _emptyMoodWarningMessage = 'Please Select a mood';
      });
      return;
    }

    debugPrint('[New Post] Form field check passed');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(

          type: MaterialType.transparency,
          //color: Colors.white,

          child: Center(
            child: Container(

              width: 180,
              height:150,
              color: Colors.white,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Loading...', 
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )
                  ),
                  
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10),),

                  CircularProgressIndicator()
                ]
              ),
            ),
          )
        );
      }
    );

    // Prepare post data
    PostData data = PostData(mood: _currentMood, description: _descriptionFieldController.text);

    OperationResponse response = await DataManagement.submitNewPost(data);

    // Dismiss the modal
    Navigator.pop(context);


    if (response.isError){
      // Fail, show error message

      setState((){
        _failSubmitPostMessage = response.message;
      });
    }
    else{
    
      // Success, return to home
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(top:12, left:12, right:12),
      color: currentBackgroundColor(),

      child: ListView(

        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          _failSubmitPostMessage == ''
          ? Container()
          : FormSection(

              children: <Widget>[
                Text(_failSubmitPostMessage, style: TextStyle(color: Colors.red),)
              ]
            ),

          FormSection(
            
            // List Tile default have padding
            padding: EdgeInsets.all(0),
            children: <Widget>[

              ListTile(

                leading: CircleAvatar(),
                title: Text(GlobalState.userProfile.nickname),
                subtitle: Text('Hello! World?'),
              ),
              

            ],
          ),


          FormSection(

            children: <Widget>[

              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[


                    Text(
                      'Hows your mood?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )
                    ),

                    this._currentMood == null 
                      ? Container()
                      : Text('${_currentMood.moodTypeString}')

                  ]
                ),
              ),

              this._emptyMoodWarningMessage == ''
               ? Container()
               : Text('$_emptyMoodWarningMessage', style: TextStyle(color: Colors.red),),
            
              Container(
                // margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.teal[100],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    IconButton(
                      onPressed: (){onMoodSelected(0);},
                      icon: Icon(Icons.sentiment_very_dissatisfied),
                      color: _currentMood.moodType == MoodType.VeryUnhappy ? moodColorMap[MoodType.VeryUnhappy] : Colors.black,
                    ),
                    IconButton(
                      onPressed: (){onMoodSelected(1);},
                      icon: Icon(Icons.sentiment_dissatisfied),
                      color: _currentMood.moodType == MoodType.Unhappy ? moodColorMap[MoodType.Unhappy] : Colors.black,
                    ),
                    IconButton(
                      onPressed: (){onMoodSelected(2);},
                      icon: Icon(Icons.sentiment_neutral),
                      color: _currentMood.moodType == MoodType.Neutral ? moodColorMap[MoodType.Neutral] : Colors.black,
                    ),
                    IconButton(
                      onPressed: (){onMoodSelected(3);},
                      icon: Icon(Icons.sentiment_satisfied),
                      color: _currentMood.moodType == MoodType.Happy ? moodColorMap[MoodType.Happy] : Colors.black,
                    ),
                    IconButton(
                      onPressed: (){onMoodSelected(4);},
                      icon: Icon(Icons.sentiment_very_satisfied),
                      color: _currentMood.moodType == MoodType.VeryHappy ? moodColorMap[MoodType.VeryHappy] : Colors.black,
                    )

                  ],
                )
              )
            ]
          ),

          // TODO: Can add some emotion phrase

          FormSection(

            children: <Widget>[

              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[


                    Text(
                      'How strong is your mood?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )
                    ),

                    this._currentMood == null 
                      ? Container()
                      : Text('${_currentMood.intensity}')

                  ]
                ),
              ),
              Slider(
                
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: this._currentMood.moodType == null 
                  ? null
                  : (val){onIntensityChanged(val.round());},
                // onChanged: null,
                value: _currentMood.intensity.toDouble(),
              )
            ],  

          ),

          FormSection(

            children: <Widget>[

              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[

                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ]
                ),
              ),

              TextField(
                controller: _descriptionFieldController,
                textInputAction: TextInputAction.newline,
                focusNode: _descriptionFieldFocusNode,
                onTap: (){
                  clearFieldFocus();
                },
                maxLength: 1000,
                maxLines: null,

              )
            ],
          ),



        ],
      )
    );
  }

  @override
  void dispose(){

    // Clean up the text edit controller here:
    _descriptionFieldController.dispose();
    _descriptionFieldFocusNode.dispose();
    super.dispose();
  } 
}