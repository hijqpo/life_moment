
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/system_data.dart';

class NotificationData {

  NotificationData({
    this.type, 
    this.detail, 
    this.read, 
    this.time,
    this.avatarURL,
    
  });

  static NotificationData createFromDataMap(Map<String, dynamic> dataMap){
    
    dynamic _type = dataMap['type'];
    if (_type == null || _type is! String){
      debugPrint('[Notification Data] type is not found in dataMap, replaced with none');
      _type = 'none';
    }

    dynamic _detail = dataMap['detail'];
    if (_detail == null || _detail is! String){
      debugPrint('[Notification Data] detail is not found in dataMap, replaced with none');
      _detail = 'none';
    }

    dynamic _read = dataMap['read'];
    if (_read == null || _read is! bool){
      _read = false;
    }

    dynamic _timestamp = dataMap['time'];
    int _seconds = 0;
    int _nanoseconds = 0;

    if (_timestamp == null || _timestamp is! DateTime){
      //debugPrint('[Notification Data] ${typeOf(_timestamp)}');
      debugPrint('[Notification Data] time is not found in dataMap, replaced with none');
      _seconds = 0;
      _nanoseconds = 0;
    }
    else{

      // dynamic _tempSec = _timestamp['_seconds']; 
      // if (_tempSec == null || _tempSec is! int){
      //   _seconds = 0;
      // }
      // else{
      //   _seconds = _tempSec;
      // }

      // dynamic _tempNanosec = _timestamp['_nanoseconds']; 
      // if (_tempNanosec == null || _tempNanosec is! int){
      //   _nanoseconds = 0;
      // }
      // else{
      //   _nanoseconds = _tempNanosec;
      // }
      
    }

    //DateTime _time = Timestamp(_seconds, _nanoseconds).toDate();
    DateTime _time = _timestamp;

    dynamic _avatarURL = dataMap['avatarURL'];
    if (_avatarURL == null || _avatarURL is! String){

      _avatarURL = UserProfile.defaultAvatarURL;
    }



    return NotificationData(

      type: _type,
      detail: _detail,

      read: _read,
      time: _time,

      avatarURL: _avatarURL,
    );
  }

  String type;
  String detail;

  bool read;
  DateTime time;

  String avatarURL;
  
  // Post related data
  String nickname1;
  String nickname2;
  String nickname3;



}