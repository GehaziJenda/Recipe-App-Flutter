import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color? color;
  final double? width;
  final double? textSize;
  final IconData? icon;
  const ButtonPrimary(
      {super.key,
      required this.text,
      required this.onClick,
      this.color,
      this.textSize,
      this.icon,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onClick.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.p20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.p16, horizontal: Sizes.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Colors.white,
                ),
                gapW12,
              ],
              TextWidget(
                text: text,
                size: textSize ?? 16,
                color: Colors.white,
                fontFamily: Fonts.semiBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
