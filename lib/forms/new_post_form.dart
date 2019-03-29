import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/forms/form_widgets/emotion_tag.dart';
import 'package:life_moment/forms/form_widgets/form_section.dart';
import 'package:life_moment/services/post_management.dart';
import 'package:life_moment/state.dart';
import 'package:life_moment/widgets/loading_modal.dart';




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

  List<String> _selectableEmotion = [];
  List<String> _selectedEmotion = [];

  Mood _currentMood = Mood();

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

  Color currentBackgroundColor(){

    if (_currentMood == null) return Colors.white;
    // if (moodColorMap == null) return Colors.white;

    double lerp = (_currentMood.intensity.toDouble() / 200); 
    if (lerp >= 0.5) lerp = 0.5;
    if (lerp <= 0) lerp = 0;


    // return moodColorMap[_currentMood.moodType] == null 
    //   ? Colors.white 
    //   : moodColorMap[_currentMood.moodType].withOpacity(0.5 + lerp);
    return _currentMood.moodColor;
  }

  void clearFieldFocus(){
    if (_descriptionFieldFocusNode.hasFocus){
      _descriptionFieldFocusNode.unfocus();
    }
  }

  void onEmotionTagSelected(String val){

  }

  void onEmotionTagUnselected(String val){

    if (_selectedEmotion.contains(val)){
      _selectedEmotion.remove(val);
    }



  }

  void onSubmit() async{

    debugPrint('Submit is pressed');

    clearFieldFocus();

    // Set warning messgae
    if (_currentMood.moodType == MoodType.Undefined){
      setState((){
        _emptyMoodWarningMessage = 'Please Select a mood';
      });
      return;
    }

    setState((){
      _failSubmitPostMessage = '';
    });

    debugPrint('[New Post] Form field check passed');

    // Show the loading modal
    showDialog(
      context: context,
      builder: (BuildContext context) => LoadingModal()
    );

    // Prepare post data
    PostData data = PostData(
      mood: _currentMood, 
      description: _descriptionFieldController.text
    );

    OperationResponse response = await PostManagement.createNewPost(data);

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

          _buildErrorMessgaeSection(),
          
          _buildProfileSection(),
          
          _buildMoodSelectionSection(),

          _buildIntensitySelectionSection(),

          _buildEmotionSelectionSection(),

          _buildDescriptionSection(),

        ],
      )
    );
  }

  Widget _buildErrorMessgaeSection(){

    if (_failSubmitPostMessage == ''){
      return Container();
    }
  
    return FormSection(

      children: <Widget>[
        Text(_failSubmitPostMessage, style: TextStyle(color: Colors.red),)
      ]
    );
  }


  Widget _buildProfileSection(){

    UserProfile userProfile = GlobalState.userProfile;
    return FormSection(
            
      // List Tile default have padding
      padding: EdgeInsets.all(0),
      children: <Widget>[

        ListTile(

          leading: CircleAvatar(
            backgroundImage: NetworkImage(userProfile.avatarURL),
          ),
          title: Text(userProfile.nickname),
          subtitle: Text('Hello! World?'),
        ),
        

      ],
    );
  }

  Widget _buildMoodSelectionSection(){

    return FormSection(

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
                color: _currentMood.moodType == MoodType.VeryUnhappy ? _currentMood.moodRawColor : Colors.black,
              ),
              IconButton(
                onPressed: (){onMoodSelected(1);},
                icon: Icon(Icons.sentiment_dissatisfied),
                color: _currentMood.moodType == MoodType.Unhappy ? _currentMood.moodRawColor : Colors.black,
              ),
              IconButton(
                onPressed: (){onMoodSelected(2);},
                icon: Icon(Icons.sentiment_neutral),
                color: _currentMood.moodType == MoodType.Neutral ? _currentMood.moodRawColor : Colors.black,
              ),
              IconButton(
                onPressed: (){onMoodSelected(3);},
                icon: Icon(Icons.sentiment_satisfied),
                color: _currentMood.moodType == MoodType.Happy ? _currentMood.moodRawColor : Colors.black,
              ),
              IconButton(
                onPressed: (){onMoodSelected(4);},
                icon: Icon(Icons.sentiment_very_satisfied),
                color: _currentMood.moodType == MoodType.VeryHappy ? _currentMood.moodRawColor : Colors.black,
              )

            ],
          )
        )
      ]
    );
  }

  Widget _buildIntensitySelectionSection(){

    return FormSection(

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
    );
  }

  Widget _buildEmotionSelectionSection(){

    //List<Emotion> emotionList = Emotion.fromListFromMood(_currentMood);
    List<String> emotionList = ['A emotion', 'Angey', 'Want Fuck', 'Sad', 'Depressed'];

    return FormSection(

      children: <Widget>[

        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            'Add emotions',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            )
          ),
        ),

        Container(
          height: 50,
          child: ListView(
            
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
              EmotionTag('SomeWordLL'),
            ],  
          ),
        )
        
      ],
    );
  }

  Widget _buildDescriptionSection(){

    return FormSection(

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