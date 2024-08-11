import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/common/text_widget.dart';
import 'package:recipe_app_flutter/constants/app_colors.dart';
import 'package:recipe_app_flutter/constants/fonts.dart';
import 'package:recipe_app_flutter/constants/strings.dart';
import 'package:recipe_app_flutter/home/screens/categories_tab.dart';
import 'package:recipe_app_flutter/home/screens/regions_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //variable for tab controller
  late final TabController _tabController;

  //init state
  @override
  void initState() {
    //init tab controller
    _tabController = TabController(length: 2, vsync: this);
    //wait for widget tree to build
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        centerTitle: false,
        title: TextWidget(
          text: Strings.welcome.toUpperCase(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryColor,
          labelStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontFamily: Fonts.bold,
          ),
          unselectedLabelStyle:
              const TextStyle(color: Colors.black, fontFamily: Fonts.regular),
          tabs: const [
            Tab(
              text: Strings.categories,
            ),
            Tab(
              text: Strings.regions,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CategoriesTab(),
          RegionsTab(),
        ],
      ),
    );
  }
}
