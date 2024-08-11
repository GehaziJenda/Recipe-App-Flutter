import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/strings.dart';

class Dialogs {
  //for dialogs with one action
  static dialogInform(BuildContext buildContext, String dialogMessage,
      VoidCallback function, String? text) {
    return Platform.isAndroid
        ? showDialog(
            context: buildContext,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: TextWidget(text: dialogMessage),
                actions: <Widget>[
                  TextButton(
                    child: Text(text ?? Strings.ok),
                    onPressed: () {
                      function.call();
                    },
                  ),
                ],
              );
            },
          )
        : showCupertinoDialog(
            context: buildContext,
            barrierDismissible: false,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  content: TextWidget(text: dialogMessage),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        function.call();
                      },
                      child: Text(text ?? Strings.ok),
                    ),
                  ],
                ));
  }

  static loading(BuildContext context) {
    return Platform.isAndroid
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return const Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => const CupertinoActivityIndicator(
              color: AppColors.primaryColor,
              radius: 20,
            ),
          );
  }

  static loadingWithMessage(BuildContext context, String message) {
    return Platform.isAndroid
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: message,
                      size: 16,
                    )
                  ],
                ),
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: message,
                    size: 16,
                  )
                ],
              ),
            ),
          );
  }

  static Widget loadingInScreen() {
    return Platform.isAndroid
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
        : const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.primaryColor,
              radius: 20,
            ),
          );
  }
}
