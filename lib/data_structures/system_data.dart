
import 'package:flutter/foundation.dart';

class OperationResponse {

  OperationResponse(this.code, this.isError, this.message);

  static OperationResponse ok = OperationResponse(0, false, 'OK');

  final int code;
  final bool isError;
  final String message;

}


class UserProfile {

  UserProfile ({
    @required this.documentID, 
    this.nickname = 'NO NAME', 
    this.email, 
    this.gender = '葉承志', 
    this.telephone,
    this.uid = 'Default UID', 
  });

  String nickname;
  String firstName;
  String lastName;
  String email;
  String gender;
  String telephone;

  String uid;
  String documentID;
}