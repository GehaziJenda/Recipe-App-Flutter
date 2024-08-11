import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/dialogs.dart';
import 'package:recipe_app_flutter/common/future_builder_error.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/endpoints.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/constants/strings.dart';
import 'package:recipe_app_flutter/home/models/regions_model.dart';
import 'package:recipe_app_flutter/meals/models/category_meals.dart';
import 'package:recipe_app_flutter/home/models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app_flutter/meals/widgets/meal_widget.dart';

class MealsScreen extends StatefulWidget {
  //either pass a category or a region when creating this screen
  final Category? category;
  final Region? region;
  const MealsScreen({super.key, this.category, this.region})
      : assert(category != null || region != null,
            "Either category or region must be provided");

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  //get category meals
  Future<http.Response> getCategoryMeals() async {
    final response = await http.get(
        Uri.parse(Strings.baseUrl +
            Endpoints.categoryMeals +
            widget.category!.strCategory),
        headers: {"Accept": "application/json"});
    return response;
  }

  //get region meals
  Future<http.Response> getRegionMeals() async {
    final response = await http.get(
        Uri.parse(
            Strings.baseUrl + Endpoints.regionMeals + widget.region!.strArea),
        headers: {"Accept": "application/json"});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: false,
        title: TextWidget(
          text: widget.category != null
              ? widget.category!.strCategory
              : widget.region!.strArea,
          color: Colors.white,
          fontFamily: Fonts.bold,
          size: 20,
        ),
      ),
      body: FutureBuilder(
        future: widget.category != null ? getCategoryMeals() : getRegionMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            //whenever the future is not complete
            return Dialogs.loadingInScreen();
          } else if (snapshot.hasData) {
            //future has completed successfully
            log(snapshot.data?.body ?? "");
            //create category meals object
            final meals = mealsFromJson(snapshot.data!.body);
            //display list of categories
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
                itemCount: meals.meals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 50,
                  childAspectRatio: 0.75,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return MealWidget(meal: meals.meals[index]);
                },
              ),
            );
          } else if (snapshot.hasError) {
            //future has completed but failed
            //checking if it is due to internet connection
            if (snapshot.error is SocketException) {
              return FutureBuilderError(
                errorText: Strings.noInternetConnection,
                onClick: () {
                  setState(() {});
                },
              );
            }
            //checking if it is a timeout error
            else if (snapshot.error is TimeoutException) {
              return FutureBuilderError(
                errorText: Strings.requestTimedOut,
                onClick: () {
                  setState(() {});
                },
              );
            }
            //give generic error for other errors
            else {
              return FutureBuilderError(
                errorText: Strings.somethingWentWrong,
                onClick: () {
                  setState(() {});
                },
              );
            }
          } else {
            // if future has no data
            return FutureBuilderError(
              errorText: Strings.noData,
              onClick: () {
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }
}
