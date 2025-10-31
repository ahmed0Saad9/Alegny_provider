class BaseCategoryModel {
  final List<CategoryModel> companyCategories;

  const BaseCategoryModel({
    required this.companyCategories,
  });

  @override
  String toString() {
    return 'BaseCompanyCategoryModel{ CompanyCategories: $companyCategories,}';
  }

  factory BaseCategoryModel.fromMap(Map<String, dynamic> json) {
    return BaseCategoryModel(
      companyCategories: json['data'] != null
          ? List.from(json['data'])
              .map((e) => CategoryModel.fromMap(e))
              .toList()
          : [],
    );
  }

}

class CategoryModel {
  final int id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return 'CompanyCategoryModel{ id: $id, name: $name,}';
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ??0,
      name: map['name'] ??'',
    );
  }
}
