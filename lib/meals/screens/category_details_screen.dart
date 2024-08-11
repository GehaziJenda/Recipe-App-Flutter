import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/home/models/categories_model.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final Category category;
  const CategoryDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: category.idCategory,
                child: ExtendedImage.network(
                  category.strCategoryThumb,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                bottom: Sizes.p20,
                right: Sizes.p20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.p20, vertical: Sizes.p12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(Sizes.p12),
                  ),
                  child: TextWidget(
                    text: category.strCategory,
                    color: Colors.white,
                    fontFamily: Fonts.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Sizes.p48, left: Sizes.p20),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(Sizes.p12),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.grey),
                    child: const Icon(FontAwesomeIcons.arrowLeft),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p20, vertical: Sizes.p20),
              child: SingleChildScrollView(
                child: TextWidget(
                  text: category.strCategoryDescription,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
