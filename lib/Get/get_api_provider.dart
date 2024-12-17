import 'package:flutter/material.dart';
import 'package:intern_practice/Get/api_service.dart';
import 'package:intern_practice/Get/api_service_impl.dart';
import 'package:intern_practice/Post/core/api_response.dart';
import 'package:intern_practice/Post/core/status_util.dart';

class GetApiProvider extends ChangeNotifier {
  ApiService apiService = ApiServiceImpl();

  List<dynamic> data = [];
  String? errorMessage;
  StatusUtil _getApiStatus = StatusUtil.none;
  StatusUtil get getApiStatus => _getApiStatus;

  setGetApiStatus(StatusUtil status) {
    _getApiStatus = status;
    notifyListeners();
  }

  Future<void> getApiData() async {
    if (_getApiStatus != StatusUtil.loading) {
      setGetApiStatus(StatusUtil.loading);
    }

    ApiResponse apiResponse = await apiService.getData();

    if (apiResponse.statusUtil == StatusUtil.success) {
      data = apiResponse.data;
      setGetApiStatus(StatusUtil.success);
    } else if (apiResponse.statusUtil == StatusUtil.error) {
      errorMessage = apiResponse.errorMessage;
      setGetApiStatus(StatusUtil.error);
    }
  }
}
