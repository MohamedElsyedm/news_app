import 'package:flutter/material.dart';
import 'package:news_app/constants/constants_text.dart';

class CategoryModel {
  String id;
  String imgName;
  String name;

  CategoryModel({required this.id, required this.imgName, required this.name});

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      imgName: ConstantsText.generalImage,
      name: 'General',
    ),
    CategoryModel(
      id: 'technology',
      imgName: ConstantsText.technologyImage,
      name: 'Technology',
    ),
    CategoryModel(
      id: 'sports',
      imgName: ConstantsText.sportsImage,
      name: 'Sports',
    ),
    CategoryModel(
      id: 'science',
      imgName: ConstantsText.scienceImage,
      name: 'Science',
    ),
    CategoryModel(
      id: 'health',
      imgName: ConstantsText.healthImage,
      name: 'Health',
    ),
    CategoryModel(
      id: 'entertainment',
      imgName: ConstantsText.entertainmentImage,
      name: 'Entertainment',
    ),
    CategoryModel(
      id: 'business',
      imgName: ConstantsText.businessImage,
      name: 'Business',
    ),
  ];
}
