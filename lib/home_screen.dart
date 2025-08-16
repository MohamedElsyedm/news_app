import 'package:flutter/material.dart';
import 'package:news_app/categories/categories_view.dart';

class HomeScreen extends StatelessWidget {
  static const String routName = '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: CategoriesView(),
    );
  }
}
