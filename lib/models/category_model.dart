class CategoryModel {
  String id;
  String imgName;
  String imgNameDark;
  String name;

  CategoryModel({
    required this.id,
    required this.imgName,
    required this.imgNameDark,
    required this.name,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      imgName: 'general',
      imgNameDark: 'general_dark',
      name: 'General',
    ),
    CategoryModel(
      id: 'technology',
      imgName: 'technology',
      imgNameDark: 'technology_dark',
      name: 'Technology',
    ),
    CategoryModel(
      id: 'sports',
      imgName: 'sports',
      imgNameDark: 'sports_dark',
      name: 'Sports',
    ),
    CategoryModel(
      id: 'science',
      imgName: 'science',
      imgNameDark: 'science_dark',
      name: 'Science',
    ),
    CategoryModel(
      id: 'health',
      imgName: 'helth',
      imgNameDark: 'helth_dark',
      name: 'Health',
    ),
    CategoryModel(
      id: 'entertainment',
      imgName: 'entertainment',
      imgNameDark: 'entertainment_dark',
      name: 'Entertainment',
    ),
    CategoryModel(
      id: 'business',
      imgName: 'business',
      imgNameDark: 'business_dark',
      name: 'Business',
    ),
  ];
}
