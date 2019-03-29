import 'dart:io';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_moment/data_structures/friend_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/services/auth_management.dart';
import 'package:life_moment/services/user_management.dart';

import 'package:life_moment/state.dart';
import 'package:life_moment/views/structure.dart';
import 'package:life_moment/widgets/loading_modal.dart';


class EditProfileView extends StatefulWidget {

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {


  final _nicknameFieldController = TextEditingController();

  String _originalNickname = '';

  String _errorMessage = '';
  File _avatarImage;
  bool _showNewAvatarImage = false;
  bool _dirty = false;

  UserProfile _userProfile;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   //  _originalNickname = AppContext.of(context).userProfile.nickname;
  //   // _nicknameFieldController.text = _originalNickname;
  //   debugPrint('hello');
  //   // debugPrint(AppContext.of(widget.context).toString());
  //   // _userProfile = AppContext.of(widget.context).userProfile;
  //   _userProfile = GlobalState.userProfile;
  //   _originalNickname = _userProfile.nickname;
  //   _nicknameFieldController.text = _originalNickname;
  // }

  @override
  void initState(){
    super.initState();
    _userProfile = GlobalState.userProfile;
    _originalNickname = _userProfile.nickname;
    _nicknameFieldController.text = _originalNickname;

  }



  Future<void> _onDonePressed() async{
    debugPrint('[Edit Profile View] Done is pressed');

    if (_dirty){

      showDialog(
        context: context,
        builder: (BuildContext context) => LoadingModal()
      );

      var newNickname;
      if (_nicknameFieldController.text != _originalNickname){
        newNickname = _nicknameFieldController.text;
      }

      OperationResponse response = await UserManagement.updateUserProfile(nickname: newNickname, avatarFile: _avatarImage);

      Navigator.pop(context);

      if (response.isError){
        setState(() {
          _errorMessage = response.message;
        });
      }
      else{
        Navigator.pop(context);
      }
    }
    else{
      debugPrint('[Edit Profile View] Nothing is changed');
      Navigator.pop(context);
      return;
    }
  }

  void _onFieldChanged(String text){

    _dirty = true;
  }

  Future<void> _onChangeAvatarPressed() async{
    debugPrint('[Edit Profile View] Change Avatar is pressed');

    _avatarImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_avatarImage != null){
        _showNewAvatarImage = true;
        _dirty = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    // UserProfile profile = GlobalState.userProfile;

    return Scaffold(
        
      appBar: PreferredSize(
        preferredSize: Size(0, 40),
        child: AppBar(
          automaticallyImplyLeading: true,

          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w600
            )
          ),

          actions: <Widget>[
            FlatButton(
            onPressed: _onDonePressed,
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500
              )
            ),
          ),
          ],
        ),
      ),
        
      body: Center(
        
        child: Column(
          children: <Widget>[

            _buildErrorMessageSection(),

            _buildAvatarSection(_userProfile),

            _buildNicknameField(),
            // Divider(height: 0,),

           
            // _buildBasicProfile(),
          ],
        )
      ),
    );
  }


  Widget _buildErrorMessageSection(){

    if (_errorMessage == ''){
      return Container();
    }
    else{
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          '$_errorMessage',
          style: TextStyle(
            color: Colors.red
          )
        ),
      );
    }
  }

  Widget _buildAvatarSection(UserProfile profile){

    String avatarURL = profile.avatarURL;

    ImageProvider image;
    if (_showNewAvatarImage){
      image = FileImage(_avatarImage);
    }
    else{
      image = NetworkImage(avatarURL);
    }

    return Container(

      color: Colors.black12,
      child: Center(

        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: CircleAvatar(
                backgroundImage: image,
                radius: 40,
              ),
            ),

            FlatButton(
              onPressed: _onChangeAvatarPressed,
              child: Text(
                'Change Profile Picture',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
                )
              ),
            )

          ],
        )
      ),
    );
  }

  Widget _buildNicknameField(){

    return Row(
      children: <Widget>[

        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nickname',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              )
            ),
          )
        ),

        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _nicknameFieldController,
              onChanged: _onFieldChanged,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54))
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose(){

    _nicknameFieldController.dispose();
    super.dispose();
  }

}