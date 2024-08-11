import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/meals/models/category_meals.dart';

class MealWidget extends StatelessWidget {
  final Meal meal;
  const MealWidget({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Sizes.p8),
              topLeft: Radius.circular(Sizes.p8),
            ),
            child: ExtendedImage.network(
              meal.strMealThumb,
              fit: BoxFit.cover,
              height: Sizes.p128,
              width: double.infinity,
            ),
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p12,
            ),
            child: TextWidget(
              text: meal.strMeal,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
