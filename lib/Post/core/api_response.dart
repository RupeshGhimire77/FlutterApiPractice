import 'package:intern_practice/Post/core/status_util.dart';

class ApiResponse {
  String? errorMessage;
  dynamic data;
  StatusUtil? statusUtil;

  ApiResponse({this.data, this.errorMessage, this.statusUtil});
}
