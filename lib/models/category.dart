import 'dart:convert';

Categories categoriesFromJson(String str) {
  return Categories.fromJson(jsonDecode(str));
}

class Categories {
  List<Category>? categories;

  Categories({this.categories});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;
  List<String>? subcategory;

  Category({this.name, this.subcategory});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subcategory = json['subcategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['subcategory'] = subcategory;
    return data;
  }
}
