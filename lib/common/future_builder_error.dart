import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/common/button_primary.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/strings.dart';

class FutureBuilderError extends StatelessWidget {
  final String errorText;
  final VoidCallback onClick;
  const FutureBuilderError(
      {super.key, required this.errorText, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: Strings.noInternetConnection),
            gapH20,
            ButtonPrimary(
                text: Strings.retry,
                icon: FontAwesomeIcons.rotateRight,
                onClick: () {
                  onClick.call();
                })
          ],
        ),
      ),
    );
  }
}
