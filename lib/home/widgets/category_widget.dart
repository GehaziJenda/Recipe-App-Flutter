import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/meals/screens/category_details_screen.dart';
import 'package:recipe_app_flutter/meals/screens/meals_screen.dart';
import 'package:recipe_app_flutter/home/models/categories_model.dart';
import 'package:recipe_app_flutter/utilities/navigation.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.navigateTo(
          context,
          MealsScreen(
            category: category,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.p8,
          horizontal: Sizes.p12,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(Sizes.p20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigation.navigateTo(
                      context,
                      CategoryDetailsScreen(category: category),
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.circleInfo,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
            gapH16,
            Hero(
              tag: category.idCategory,
              child: ExtendedImage.network(
                category.strCategoryThumb,
                height: 80,
              ),
            ),
            gapH16,
            TextWidget(text: category.strCategory)
          ],
        ),
      ),
    );
  }
}
