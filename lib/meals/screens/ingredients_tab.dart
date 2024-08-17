import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/strings.dart';

class IngredientsTab extends StatefulWidget {
  final Map<String, String?> meal;
  const IngredientsTab({super.key, required this.meal});

  @override
  State<IngredientsTab> createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  final ingredientsList = <Map<String, String>>[];

  //function to get ingredients and corresponding measurements
  void listIngredientsAndMeasurements(Map<String, dynamic> mealData) {
    // Loop through ingredient and measurement fields
    for (int i = 1; i <= 20; i++) {
      // Accessing ingredient and measurement fields
      String? ingredient = mealData['strIngredient$i'];
      String? measurement = mealData['strMeasure$i'];

      // Only add to list if ingredient is not null/empty and measurement is not null/empty
      if (ingredient != null &&
          ingredient.isNotEmpty &&
          measurement != null &&
          measurement.isNotEmpty) {
        ingredientsList
            .add({"ingredient": ingredient, "measurement": measurement});
      }
    }
  }

  @override
  void initState() {
    //wait for widget tree to build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //add ingredients and measurements to list
      listIngredientsAndMeasurements(widget.meal);
      //refresh UI
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingredientsList.length,
        padding: const EdgeInsets.only(
            left: Sizes.p20, right: Sizes.p20, top: Sizes.p20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final ingredient = ingredientsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: Sizes.p16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.p8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.p12),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: ExtendedImage.network(
                        "${Strings.imageUrl}${ingredient["ingredient"]}-Small.png",
                        height: 35,
                      ),
                    ),
                    gapW12,
                    Column( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: ingredient["ingredient"] ?? ""),
                        gapH4,
                        TextWidget(
                          text: ingredient["measurement"] ?? "",
                          color: AppColors.textGrey,
                          size: 14,
                        ),
                      ],
                    )
                  ],
                ),
                gapH8,
                Container(
                  color: AppColors.grey,
                  height: 1,
                  width: double.infinity,
                )
              ],
            ),
          );
        });
  }
}
