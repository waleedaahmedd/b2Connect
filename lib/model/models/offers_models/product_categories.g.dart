part of 'product_categories.dart';

ProductCategories _$ProductCategoriesFromJson(Map<String, dynamic> json){
  return ProductCategories(
    id: json["id"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      order: json["order"],
      name: json["name"],
      parent: json["parent"],
      slug: json["slug"],
  );
}

Map<String, dynamic> _$ProductCategoriesToJson(ProductCategories instance) => <String, dynamic>{
    "id": instance.id,
    "description": instance.description,
    "imageUrl": instance.imageUrl,
    "order": instance.order,
    "name": instance.name,
    "parent": instance.parent,
    "slug": instance.slug,

};