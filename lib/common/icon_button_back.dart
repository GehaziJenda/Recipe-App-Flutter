import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';

class IconButtonBack extends StatelessWidget {
  final VoidCallback? onClick;
  const IconButtonBack({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.p48, left: Sizes.p20),
      child: IconButton(
        onPressed: () {
          if(onClick != null) {
            onClick!.call();
          }
          Navigator.pop(context);
        },
        icon: Container(
          padding: const EdgeInsets.all(Sizes.p12),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.grey),
          child: const Icon(FontAwesomeIcons.arrowLeft),
        ),
      ),
    );
  }
}