import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
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
              )
            ],
          )
        ],
      ),
    );
  }
}
