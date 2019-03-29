
import 'dart:math';

import 'package:flutter/material.dart';



class Emotion {

  Emotion({String type, int defaultMoodTypeCode, int defaultMoodIntensity}){
    //_type = type;
  }

  static Map<String, IntensityInterval> emotionTagMap = {

    'Amazed': IntensityInterval.randomDistribution,       
    'Confident': IntensityInterval.randomDistribution,    
    'Determined': IntensityInterval.randomDistribution,
    'Excited': IntensityInterval.randomDistribution,
    'Ecstatic': IntensityInterval.randomDistribution,
    'Energetic': IntensityInterval.randomDistribution,
    'Astonished': IntensityInterval.randomDistribution,
    'Optimistic': IntensityInterval.randomDistribution,
    'Peaceful': IntensityInterval.randomDistribution,
    'Powerful': IntensityInterval.randomDistribution,
    'Proud': IntensityInterval.randomDistribution,
    'Joy': IntensityInterval.randomDistribution,
    'Anticipated': IntensityInterval.randomDistribution,
    'Surprised': IntensityInterval.randomDistribution,
    'Inspired': IntensityInterval.randomDistribution,
    'Hopeful': IntensityInterval.randomDistribution,
    'Love': IntensityInterval.randomDistribution,
    'Brave': IntensityInterval.randomDistribution,
    'Devastated': IntensityInterval.randomDistribution,
    'Insecure': IntensityInterval.randomDistribution,
    'Furious': IntensityInterval.randomDistribution,
    'Enraged': IntensityInterval.randomDistribution,
    'Skeptical': IntensityInterval.randomDistribution,
    'Sarcastic': IntensityInterval.randomDistribution,
    'Irritated': IntensityInterval.randomDistribution,
    'Embarrassed': IntensityInterval.randomDistribution,
    'Worthless': IntensityInterval.randomDistribution,
    'Inadequate': IntensityInterval.randomDistribution,
    'Fear': IntensityInterval.randomDistribution,
    'Anxious': IntensityInterval.randomDistribution,
    'Humiliated': IntensityInterval.randomDistribution,
    'Suspicious': IntensityInterval.randomDistribution,
    'Powerless': IntensityInterval.randomDistribution,
    'Bored': IntensityInterval.randomDistribution,
    'Despair': IntensityInterval.randomDistribution,
    'Sadness': IntensityInterval.randomDistribution,
    'Ashamed': IntensityInterval.randomDistribution,
    'Ignored': IntensityInterval.randomDistribution,
    'Grief': IntensityInterval.randomDistribution,
    'Empty': IntensityInterval.randomDistribution,
    'Lonely': IntensityInterval.randomDistribution,
    'Depressed': IntensityInterval.randomDistribution,
    'Indifferent': IntensityInterval.randomDistribution,
    'Isolated': IntensityInterval.randomDistribution,
    'Guilt': IntensityInterval.randomDistribution,
    'Shame': IntensityInterval.randomDistribution,
    'Hesitant': IntensityInterval.randomDistribution,
    'Annoyance': IntensityInterval.randomDistribution,
    'Jealous': IntensityInterval.randomDistribution,
    'Disgust': IntensityInterval.randomDistribution,
    'Angry': IntensityInterval.randomDistribution,
    'Hateful': IntensityInterval.randomDistribution,
    'Calm': IntensityInterval.randomDistribution,
    'Shyness': IntensityInterval.randomDistribution,
    'Vulnerable': IntensityInterval.randomDistribution,
    'Abandoned': IntensityInterval.randomDistribution,
    'Rage': IntensityInterval.randomDistribution,
    'Anger': IntensityInterval.randomDistribution,
    'Distraction': IntensityInterval.randomDistribution,
    'Pride': IntensityInterval.randomDistribution,
    'Determination': IntensityInterval.randomDistribution,
    'Admiration': IntensityInterval.randomDistribution,
    'Amazement': IntensityInterval.randomDistribution,
    'Trust': IntensityInterval.randomDistribution,
    'Ecstasy': IntensityInterval.randomDistribution,
  };

  
  static List<Emotion> fromListFromMood(Mood mood){

    // emotionTagMap.

    return [];
  }


  String _type;
  int moodTypeCode;
  int moodIntensity;

  @override
  String toString(){
    return '';
  }
}

class IntensityInterval {

  static const int segmentCount = 10;

  IntensityInterval(this.interval){

    if (interval == null){
      interval = _randomList;
    }
    else if (interval.length != segmentCount){
      interval =_randomList;
    }
  }

  List<int> interval;

  static IntensityInterval get randomDistribution {
    return IntensityInterval(_randomList);
  }

  static IntensityInterval get min {
    return IntensityInterval(_minList);
  }

  static IntensityInterval get max {
    return IntensityInterval(_maxList);
  }

  static List<int> get _randomList {
    Random ran = Random();
    List<int> list = [];
    for (int i=0; i<segmentCount; i++){
      list.add(ran.nextInt(11));
    }
    return list;
  }

  static List<int> get _minList {
    List<int> list = [];
    for (int i=0; i<segmentCount; i++){
      list.add(0);
    }
    return list;
  }

  static List<int> get _maxList {
    List<int> list = [];
    for (int i=0; i<segmentCount; i++){
      list.add(10);
    }
    return list;
  }
}



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

  static Color getColorWithType(int i){
    return _codeColorMap[i];
  }

  static Map<int, MoodType> _codeTypeMap = {
    -1: MoodType.Undefined,
    0: MoodType.VeryUnhappy,
    1: MoodType.Unhappy,
    2: MoodType.Neutral,
    3: MoodType.Happy,
    4: MoodType.VeryHappy,
  };

  static Map<int, IconData> _codeIconMap = {

    0: Icons.sentiment_very_dissatisfied,
    1: Icons.sentiment_dissatisfied,
    2: Icons.sentiment_neutral,
    3: Icons.sentiment_satisfied,
    4: Icons.sentiment_very_satisfied,
  };

  static Map<int, Color> _codeColorMap = {

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

class MoodChartData {
  final DateTime time;
  final int moodType;
  final int moodIntensity;

  MoodChartData(this.time, this.moodType, this.moodIntensity);

  @override
  String toString(){
    return 'time: $time, moodCode: $moodType, moodIntensity: $moodIntensity';
  }
}
