import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:life_moment/data_structures/mood_data.dart';
import 'package:life_moment/data_structures/news_feed_data.dart';
import 'package:life_moment/data_structures/system_data.dart';
import 'package:life_moment/state.dart';

class OperationManagement {

  static Future<OperationResponse> exceptionPlayground() async{

    try {

      OperationResponse res = await CloudFunctions.instance.call(
        functionName: 'exceptionPlayground',
        parameters: {
          'testCase': 'd',
        }
      );

      debugPrint('WTF?? $res');


      return OperationResponse.ok;
    }
    catch (error){

      debugPrint('Hello from catch block ${error.toString()}');
      debugPrint('Hello from catch block ${error.code}');
      debugPrint('Hello from catch block ${error.message}');
      return OperationResponse.ok;
    }
  }

  static Future<OperationResponse> clearAllPosts({String keyword}) async{

    try {

      OperationResponse res = await CloudFunctions.instance.call(
        functionName: 'clearAllPosts',
      );
      return OperationResponse.ok;
    }
    catch (error){

      debugPrint('Hello from catch block ${error.toString()}');
      debugPrint('Hello from catch block ${error.code}');
      debugPrint('Hello from catch block ${error.message}');
      return OperationResponse.ok;
    }
  }
}