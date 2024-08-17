import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/dialogs.dart';
import 'package:recipe_app_flutter/common/future_builder_error.dart';
import 'package:recipe_app_flutter/constants/app_sizes.dart';
import 'package:recipe_app_flutter/constants/endpoints.dart';
import 'package:recipe_app_flutter/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app_flutter/home/models/categories_model.dart';
import 'package:recipe_app_flutter/home/widgets/category_widget.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab>
    with AutomaticKeepAliveClientMixin {
      
  //get categories
  Future<http.Response> getCategories() async {
    final response = await http.get(
        Uri.parse(Strings.baseUrl + Endpoints.categories),
        headers: {"Accept": "application/json"});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          //whenever the future is not complete
          return Dialogs.loadingInScreen();
        } else if (snapshot.hasData) {
          //future has completed successfully
          log(snapshot.data?.body ?? "");
          //create category list object
          final categories = categoriesFromJson(snapshot.data!.body);
          //display list of categories
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
              itemCount: categories.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
                childAspectRatio: 0.8,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return CategoryWidget(
                  category: categories.categories[index],
                );
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
