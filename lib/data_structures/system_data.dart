
class OperationResponse {

  OperationResponse(this.code, this.isError, this.message);

  static OperationResponse ok = OperationResponse(0, false, 'OK');

  final int code;
  final bool isError;
  final String message;

}


class UserProfile {

  String nickname = '';

}