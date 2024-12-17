import 'package:intern_practice/Post/core/api_response.dart';

abstract class ApiService {
  Future<ApiResponse> getData();
}
