import 'package:flutter/material.dart';
import 'package:news_app/categories/data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;
  CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/${category.imgName}.png',
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
