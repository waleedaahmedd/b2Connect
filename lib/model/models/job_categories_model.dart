class JobCategories {
  int? totalJobCount;
  List<Categories>? categories;

  JobCategories({this.totalJobCount, this.categories});

  JobCategories.fromJson(Map<String, dynamic> json) {
    totalJobCount = json['totalJobCount'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalJobCount'] = this.totalJobCount;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? image;
  String? categoryId;
  String? name;
  int? jobCount;

  Categories({this.image, this.categoryId, this.name, this.jobCount});

  Categories.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    categoryId = json['category_id'];
    name = json['name'];
    jobCount = json['jobCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['jobCount'] = this.jobCount;
    return data;
  }
}