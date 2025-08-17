import 'package:flutter/material.dart';
import 'package:news_app/categories/category_item.dart';
import 'package:news_app/models/category_model.dart';

class CategoriesView extends StatelessWidget {
  void Function(CategoryModel) onCategorySelect;

  CategoriesView({required this.onCategorySelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning \nHere is Some News For You',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelect(CategoryModel.categories[index]);
                },
                child: CategoryItem(CategoryModel.categories[index]),
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
