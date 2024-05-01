class HomeModel{
  final List<String> banner;
  final List<CategoryModel> category;
  HomeModel({required this.category, required this.banner});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      banner: List<String>.from(json['banner']),
      category: List<CategoryModel>.from(json['categories'].map((x) => CategoryModel.fromJson(x))),
    );
  }
}

class CategoryModel{
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      image: json['image'],
    );
  }

}