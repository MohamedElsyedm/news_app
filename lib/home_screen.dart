import 'package:flutter/material.dart';
import 'package:news_app/categories/categories_view.dart';
import 'package:news_app/drawer/home_drawer.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/news/news_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory == null ? 'Home' : selectedCategory!.name),
      ),
      drawer: HomeDrawer(goToHome: restSelectedCategory),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelect: onCategorySelected)
          : NewsView(selectedCategory!.id),
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
}
