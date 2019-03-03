

import 'package:flutter/material.dart';

enum MoodType {

  VeryHappy,
  Happy,
  Neutral,
  Unhappy,
  VeryUnhappy,
  Undefined
}

class Mood {

  Mood({int intensity, int typeCode}){

    this._intensity = intensity;
    if (this._intensity == null) this._intensity = 0;

    this._typeCode = typeCode;
    this._type = _codeTypeMap[typeCode];
    if (this._type == null) this._type = MoodType.Undefined;

  }

  Map<int, MoodType> _codeTypeMap = {
    -1: MoodType.Undefined,
    0: MoodType.VeryUnhappy,
    1: MoodType.Unhappy,
    2: MoodType.Neutral,
    3: MoodType.Happy,
    4: MoodType.VeryHappy,
  };

  Map<int, IconData> _codeIconMap = {

    0: Icons.sentiment_very_dissatisfied,
    1: Icons.sentiment_dissatisfied,
    2: Icons.sentiment_neutral,
    3: Icons.sentiment_satisfied,
    4: Icons.sentiment_very_satisfied,
  };

  Map<int, Color> _codeColorMap = {

    0: Colors.red,
    1: Colors.red[200],
    2: Colors.green[300],
    3: Colors.yellow[200],
    4: Colors.orange,
  };

  MoodType _type;
  int _intensity;
  int _typeCode;
  
  // set intensity(double val) {
  //   _intensity = val;
  // }

  set intensity(int val){
    this._intensity = val;
  }

  set moodTypeCode(int val){
    this._typeCode = val;
    this._type = _codeTypeMap[val];
  }

  int get intensity {

    if (_intensity == null) return 0;
    if (_intensity >= 100) return 100;
    if (_intensity <= 0) return 0;

    return _intensity;
  }

  MoodType get moodType {
    return _type;
  }

  String get moodTypeString {

    switch(this._type){

      case MoodType.VeryHappy:
        return 'Very Happy';

      case MoodType.Happy:
        return 'Happy';

      case MoodType.Neutral:
        return 'Neutral';

      case MoodType.Unhappy:
        return 'Unhappy';

      case MoodType.VeryUnhappy:
        return 'Very Unhappy';

      default:
        return 'UNKNOWN';
    }
  }

  Icon get moodIcon{
    Icon result = Icon(_codeIconMap[_typeCode]);
    if (result == null) return Icon(Icons.error_outline);

    return result;
  }

  Icon get colorMoodIcon{
    Icon result = Icon(
      _codeIconMap[_typeCode],
      color: _codeColorMap[_typeCode],
      semanticLabel: 'hi',
    );
    if (result == null) return Icon(Icons.error_outline);

    return result;
  }

  Color get moodColor{
    
    Color result = _codeColorMap[_typeCode];
    if (result == null) return Colors.white;

    double lerp = (intensity.toDouble() / 200); 
    if (lerp >= 0.5) lerp = 0.5;
    if (lerp <= 0) lerp = 0;


    return result.withOpacity(0.5 + lerp);
  }

  Color get moodRawColor{
    Color result = _codeColorMap[_typeCode];
    if (result == null) return Colors.white;
    return result;
  }

  int get moodTypeCode {

    return _typeCode;
  }

}