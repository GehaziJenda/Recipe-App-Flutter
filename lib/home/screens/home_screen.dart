import 'dart:async';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/endpoints.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/constants/strings.dart';
import 'package:recipe_app_flutter/home/screens/categories_tab.dart';
import 'package:recipe_app_flutter/home/screens/regions_tab.dart';
import 'package:recipe_app_flutter/meals/models/meal_details.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app_flutter/meals/models/meals.dart';
import 'package:recipe_app_flutter/meals/widgets/meal_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //variable for tab controller
  late final TabController _tabController;

  //notifier for keeping searched text
  final searchTextNotifier = ValueNotifier<String>('');
  //notifier for knowing if a search is happening or not
  final ValueNotifier<bool> isSearchingNotifier = ValueNotifier<bool>(false);
  //notifier for keeping the search results
  final searchResultsNotifier =
      ValueNotifier<MealDetails>(MealDetails(meals: []));
  //timer for ensuring that API calls are only made after user has stopped typing
  Timer? _debounce;

  //init state
  @override
  void initState() {
    //init tab controller
    _tabController = TabController(length: 2, vsync: this);
    //add listener for search text
    searchTextNotifier.addListener(_onSearchTextChanged);
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    searchTextNotifier.removeListener(_onSearchTextChanged);
    searchTextNotifier.dispose();
    searchResultsNotifier.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  //function for when search text is changed
  void _onSearchTextChanged() {
    final searchText = searchTextNotifier.value;
    isSearchingNotifier.value = searchText.isNotEmpty;

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchText.isNotEmpty) {
        _performSearch(searchText);
      } else {
        searchResultsNotifier.value = MealDetails(meals: []);
      }
    });
  }

  //function to perform search
  Future<void> _performSearch(String query) async {
    try {
      final response =
          await http.get(Uri.parse(Strings.baseUrl + Endpoints.search + query));
      if (response.statusCode == 200) {
        //convert data to meal details
        final mealDetails = mealDetailsFromJson(response.body);
        //update search result notifier
        searchResultsNotifier.value = mealDetails;
      } else {
        //failed call
        searchResultsNotifier.value = MealDetails(meals: []);
      }
    } catch (e) {
      //error
      searchResultsNotifier.value = MealDetails(meals: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        toolbarHeight: 100,
        titleTextStyle: const TextStyle(fontFamily: Fonts.regular),
        onChanged: (value) {
          searchTextNotifier.value = value;
        },
        appBarBuilder: (context) {
          return AppBar(
            backgroundColor: AppColors.grey,
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: Strings.recipesApp.toUpperCase(),
                ),
                const TextWidget(
                  text: Strings.byGehaziJenda,
                  size: 12,
                  color: AppColors.textGrey,
                )
              ],
            ),
            actions: const [
              AppBarSearchButton(
                buttonHasTwoStates: true,
              ),
            ],
            bottom: searchTextNotifier.value.isEmpty
                ? TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primaryColor,
                    labelStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: Fonts.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                        color: Colors.black, fontFamily: Fonts.regular),
                    tabs: const [
                      Tab(
                        text: Strings.categories,
                      ),
                      Tab(
                        text: Strings.regions,
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: isSearchingNotifier,
        builder: (context, isSearching, child) {
          if (isSearching) {
            return _searchResultsWidget();
          } else {
            return TabBarView(
              controller: _tabController,
              children: const [
                CategoriesTab(),
                RegionsTab(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _searchResultsWidget() {
    return ValueListenableBuilder(
      valueListenable: searchResultsNotifier,
      builder: (context, results, child) {
        if (results.meals.isEmpty) {
          return const Center(
            child: TextWidget(text: Strings.noSearchResultsFound),
          );
        }
        //display list of meals
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            itemCount: results.meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 50,
              mainAxisSpacing: 50,
              childAspectRatio: 0.75,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final meal = Meal(
                  strMeal: results.meals[index]["strMeal"] ?? "",
                  strMealThumb: results.meals[index]["strMealThumb"] ?? "",
                  idMeal: results.meals[index]["idMeal"] ?? "");
              return MealWidget(
                meal: meal,
              );
            },
          ),
        );
      },
    );
  }
}
