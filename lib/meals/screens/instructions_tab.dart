import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';

class InstructionsTab extends StatelessWidget {
  final String instructions;
  const InstructionsTab({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p20),
      child: SingleChildScrollView(
        child: TextWidget(
          text: instructions,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}
