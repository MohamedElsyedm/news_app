import 'package:flutter/material.dart';
import 'package:news_app/categories/categories_view.dart';
import 'package:news_app/constants/constants_text.dart';
import 'package:news_app/drawer/home_drawer.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/news/news_view.dart';
import 'package:news_app/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  bool isSearch = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null
              ? ConstantsText.home
              : selectedCategory!.name,
        ),
        actions: [
          selectedCategory == null
              ? SizedBox()
              : IconButton(
                  onPressed: changeSearchMode,
                  icon: Icon(Icons.search_rounded),
                ),
        ],
      ),
      drawer: HomeDrawer(goToHome: restSelectedCategory),
      body: Column(
        children: [
          isSearch
              ? CustomTextField(
                  myController: controller,
                  onSearchClosed: changeSearchMode,
                  onChanged: (value) {
                    setState(() {
                      controller.text = value;
                    });
                  },
                )
              : SizedBox(),

          selectedCategory == null
              ? Expanded(
                  child: CategoriesView(onCategorySelect: onCategorySelected),
                )
              : Expanded(
                  child: NewsView(
                    selectedCategory!.id,
                    isSearch ? controller.text : '',
                  ),
                ),
        ],
      ),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void restSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }

  void changeSearchMode() {
    setState(() {
      isSearch = !isSearch;
    });
  }
}
