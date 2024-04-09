import 'package:flutter/material.dart';
import 'package:music_app/app/app.dart';
import 'package:music_app/app/router/router_constatnts.dart';

class FcmNavigationService {
  final String? page;

  FcmNavigationService({this.page});
  Future<dynamic> navigateToPage() {
    switch (page) {
      case "/":
        return Navigator.of(navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          RouterConstants.bottomNavRoute,
          (route) => false,
        );
      case "common":
        return Navigator.of(navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          RouterConstants.bottomNavRoute,
          (route) => false,
        );
      case "notification":
        return Navigator.of(navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          RouterConstants.bottomNavRoute,
          (route) => false,
          arguments: 1,
        );
      default:
        return Navigator.of(navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(
          RouterConstants.bottomNavRoute,
          (route) => false,
        );
    }
  }
}
