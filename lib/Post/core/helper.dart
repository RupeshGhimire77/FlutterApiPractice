import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Helper {
  /// Creates an instance of InternetConnectionChecker.
  static final InternetConnectionChecker _checker =
      InternetConnectionChecker.createInstance();

  /// Checks for internet connectivity.
  static Future<bool> checkInternet() async {
    // Returns true if there is an internet connection
    return await _checker.hasConnection;
  }

  /// Displays a SnackBar with the provided message.
  static void displaySnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Optional: Customize duration
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
