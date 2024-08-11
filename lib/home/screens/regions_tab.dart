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
import 'package:recipe_app_flutter/home/models/regions_model.dart';
import 'package:recipe_app_flutter/home/widgets/region_widget.dart';

class RegionsTab extends StatefulWidget {
  const RegionsTab({super.key});

  @override
  State<RegionsTab> createState() => _RegionsTabState();
}

class _RegionsTabState extends State<RegionsTab>
    with AutomaticKeepAliveClientMixin {
  //get regions
  Future<http.Response> getRegions() async {
    final response = await http.get(
        Uri.parse(Strings.baseUrl + Endpoints.regions),
        headers: {"Accept": "application/json"});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getRegions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          //whenever the future is not complete
          return Dialogs.loadingInScreen();
        } else if (snapshot.hasData) {
          //future has completed successfully
          log(snapshot.data?.body ?? "");
          //create regions list object
          final regions = regionsFromJson(snapshot.data!.body);
          //display list of categories
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
              itemCount: regions.meals.length,
              itemBuilder: (context, index) {
                return RegionWidget(
                  meal: regions.meals[index],
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
