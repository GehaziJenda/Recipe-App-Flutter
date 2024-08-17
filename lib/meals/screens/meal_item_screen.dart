import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_app_flutter/common/dialogs.dart';
import 'package:recipe_app_flutter/common/future_builder_error.dart';
import 'package:recipe_app_flutter/common/icon_button_back.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/endpoints.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/constants/strings.dart';
import 'package:recipe_app_flutter/meals/models/meal_details.dart';
import 'package:recipe_app_flutter/meals/models/meals.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app_flutter/meals/screens/ingredients_tab.dart';
import 'package:recipe_app_flutter/meals/screens/instructions_tab.dart';

class MealItemScreen extends StatefulWidget {
  final Meal meal;
  const MealItemScreen({super.key, required this.meal});

  @override
  State<MealItemScreen> createState() => _MealItemScreenState();
}

class _MealItemScreenState extends State<MealItemScreen>
    with TickerProviderStateMixin {
  //variable for tab controller
  late final TabController _tabController;

  //get meal item details
  Future<http.Response> getMealItemDetails() async {
    final response = await http.get(
        Uri.parse(
            Strings.baseUrl + Endpoints.mealItemDetails + widget.meal.idMeal),
        headers: {"Accept": "application/json"});
    return response;
  }

  @override
  void initState() {
    //init tab controller
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //variable for screen size
    final size = MediaQuery.of(context).size;

    //variable for meal
    final meal = widget.meal;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: meal.idMeal,
                child: ExtendedImage.network(
                  meal.strMealThumb,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const IconButtonBack()
            ],
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p20,
              vertical: Sizes.p12,
            ),
            color: AppColors.grey,
            child: Column(
              children: [
                TextWidget(
                  text: meal.strMeal,
                  size: 22,
                  maxLines: 2,
                ),
                gapH16,
              ],
            ),
          ),
          FutureBuilder(
              future: getMealItemDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  //whenever the future is not complete
                  return Padding(
                    padding: const EdgeInsets.only(top: Sizes.p32),
                    child: Dialogs.loadingInScreen(),
                  );
                } else if (snapshot.hasData) {
                  //future has completed successfully
                  log(snapshot.data?.body ?? "");
                  //convert data to meal details
                  final mealDetails = mealDetailsFromJson(snapshot.data!.body);
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: Sizes.p20),
                          color: AppColors.grey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textIconPair(
                                      mealDetails.meals[0]["strArea"] ?? "-",
                                      FontAwesomeIcons.earthAmericas),
                                  textIconPair(
                                      mealDetails.meals[0]["strCategory"] ??
                                          "-",
                                      FontAwesomeIcons.utensils),
                                ],
                              ),
                              gapH12,
                              TabBar(
                                controller: _tabController,
                                dividerHeight: 0,
                                indicatorColor: AppColors.primaryColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: Fonts.bold,
                                ),
                                unselectedLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: Fonts.regular),
                                tabs: const [
                                  Tab(
                                    text: Strings.instructions,
                                  ),
                                  Tab(
                                    text: Strings.ingredients,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              InstructionsTab(
                                  instructions: mealDetails.meals[0]
                                          ["strInstructions"] ??
                                      Strings.noInstructionsAvailable),
                              const IngredientsTab(),
                            ],
                          ),
                        ),
                      ],
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
              })
        ],
      ),
    );
  }

  Widget textIconPair(String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textGrey,
          size: 18,
        ),
        gapW12,
        TextWidget(
          text: value,
          color: AppColors.textGrey,
        )
      ],
    );
  }
}
