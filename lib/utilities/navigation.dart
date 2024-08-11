import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app_flutter/common/custom_page_route.dart';

class Navigation {
  static navigateTo(BuildContext context, Widget child) {
    return Navigator.push(
        context,
        Platform.isAndroid
            ? CustomPageRoute(child: child)
            : CupertinoPageRoute(builder: (context) => child));
  }

  static navigateAndReplace(BuildContext context, Widget child) {
    return Navigator.pushAndRemoveUntil(
        context,
        Platform.isAndroid
            ? CustomPageRoute(child: child)
            : CupertinoPageRoute(builder: (context) => child),
        (Route<dynamic> route) => false);
  }
}
