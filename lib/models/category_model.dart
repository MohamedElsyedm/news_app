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
      id: '',
      imgName: 'general',
      imgNameDark: 'general_dark',
      name: 'General',
    ),
    CategoryModel(
      id: '',
      imgName: 'technology',
      imgNameDark: 'technology_dark',
      name: 'Technology',
    ),
    CategoryModel(
      id: '',
      imgName: 'sports',
      imgNameDark: 'sports_dark',
      name: 'Sports',
    ),
    CategoryModel(
      id: '',
      imgName: 'science',
      imgNameDark: 'science_dark',
      name: 'Science',
    ),
    CategoryModel(
      id: '',
      imgName: 'helth',
      imgNameDark: 'helth_dark',
      name: 'Health',
    ),
    CategoryModel(
      id: '',
      imgName: 'entertainment',
      imgNameDark: 'entertainment_dark',
      name: 'Entertainment',
    ),
    CategoryModel(
      id: '',
      imgName: 'business',
      imgNameDark: 'business_dark',
      name: 'Business',
    ),
  ];
}
