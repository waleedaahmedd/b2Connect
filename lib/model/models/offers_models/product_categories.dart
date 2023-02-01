

import 'package:json_annotation/json_annotation.dart';

part 'product_categories.g.dart';

@JsonSerializable(nullable: false)
class ProductCategories {
  ProductCategories({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.order,
    required this.name,
    required this.parent,
    required this.slug,
  });

  int id;
  String description;
  String imageUrl;
  int order;
  String name;
  int parent;
  String slug;

  factory ProductCategories.fromJson(Map<String, dynamic> json) => _$ProductCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoriesToJson(this);
}