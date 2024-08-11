import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/home/models/regions_model.dart';

class RegionWidget extends StatelessWidget {
  final Meal meal;
  const RegionWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: Sizes.p24),
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p12),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(Sizes.p4),
        ),
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.earthAmericas,
              color: AppColors.primaryColor,
              size: 20,
            ),
            gapW16,
            TextWidget(text: meal.strArea)
          ],
        ),
      ),
    );
  }
}
