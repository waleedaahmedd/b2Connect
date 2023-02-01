/*
import 'package:json_annotation/json_annotation.dart';
part 'advert_model.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class AdvertismentModel {
  AdvertismentModel({
    required this.id,
    required this.timestamp,
    required this.title,
    required this.mediaUrLs,
    required this.shortText,
    required this.fullText,
    required this.category,
    required this.offerCategories,
    required this.format,
    required this.clickRedirectLink,
    required this.clickRedirectTo,
    required this.cardWidth,
    required this.cardHeight,
    required this.regularPrice,
    required this.salePrice,
    required this.installmentPrice,
    required this.stockStatus,
    required this.author,
    required this.tags,
    required this.dateCreated,
  });

  int? id;
  int? timestamp;
  String? title;
  List<String>? mediaUrLs;
  String? shortText;
  String? fullText;
  String? category;
  List<dynamic>? offerCategories;
  String? format;
  String? clickRedirectLink;
  String? clickRedirectTo;
  int? cardWidth;
  int? cardHeight;
  dynamic regularPrice;
  dynamic salePrice;
  dynamic installmentPrice;
  String? stockStatus;
  String? author;
  List<Tag>? tags;
  int? dateCreated;

  factory AdvertismentModel.fromJson(Map<String, dynamic> json) =>
      advertModelFromJson(json);

  Map<String, dynamic> toJson() => advertModelToJson(this);
}

class Tag {
  Tag({
    required this.id,
    required this.name,
    required this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}



// List<AdvertismentModel> advertismentModelFromJson(String str) => List<AdvertismentModel>.from(json.decode(str).map((x) => AdvertismentModel.fromJson(x)));
//
// String advertismentModelToJson(List<AdvertismentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class AdvertismentModel {
//   AdvertismentModel({
//     required this.id,
//     required this.timestamp,
//     required this.title,
//     required this.mediaUrLs,
//     required this.shortText,
//     required this.fullText,
//     required this.category,
//     required this.offerCategories,
//     required this.format,
//     required this.clickRedirectLink,
//     required this.clickRedirectTo,
//     required this.cardWidth,
//     required this.cardHeight,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.installmentPrice,
//     required this.stockStatus,
//     required this.author,
//     required this.tags,
//     required this.dateCreated,
//   });
//
//   int? id;
//   int? timestamp;
//   String? title;
//   List<String>? mediaUrLs;
//   String? shortText;
//   String? fullText;
//   String? category;
//   List<dynamic>? offerCategories;
//   String? format;
//   String? clickRedirectLink;
//   String? clickRedirectTo;
//   int? cardWidth;
//   int? cardHeight;
//   dynamic regularPrice;
//   dynamic salePrice;
//   dynamic installmentPrice;
//   String? stockStatus;
//   String? author;
//   List<Tag>? tags;
//   int? dateCreated;
//
//   factory AdvertismentModel.fromJson(Map<String, dynamic> json) => AdvertismentModel(
//     id: json["id"],
//     timestamp: json["timestamp"],
//     title: json["title"],
//     mediaUrLs: List<String>.from(json["mediaURLs"].map((x) => x)),
//     shortText: json["shortText"],
//     fullText: json["fullText"],
//     category: json["category"],
//     offerCategories: List<dynamic>.from(json["offerCategories"].map((x) => x)),
//     format: json["format"],
//     clickRedirectLink: json["clickRedirectLink"],
//     clickRedirectTo: json["clickRedirectTo"],
//     cardWidth: json["cardWidth"],
//     cardHeight: json["cardHeight"],
//     regularPrice: json["regularPrice"],
//     salePrice: json["salePrice"],
//     installmentPrice: json["installmentPrice"],
//     stockStatus: json["stockStatus"],
//     author: json["author"],
//     tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
//     dateCreated: json["dateCreated"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "timestamp": timestamp,
//     "title": title,
//     "mediaURLs": List<dynamic>.from(mediaUrLs!.map((x) => x)),
//     "shortText": shortText,
//     "fullText": fullText,
//     "category": category,
//     "offerCategories": List<dynamic>.from(offerCategories!.map((x) => x)),
//     "format": format,
//     "clickRedirectLink": clickRedirectLink,
//     "clickRedirectTo": clickRedirectTo,
//     "cardWidth": cardWidth,
//     "cardHeight": cardHeight,
//     "regularPrice": regularPrice,
//     "salePrice": salePrice,
//     "installmentPrice": installmentPrice,
//     "stockStatus": stockStatus,
//     "author": author,
//     "tags": List<Tag>.from(tags!.map((x) => x.toJson())),
//     "dateCreated": dateCreated,
//   };
// }
//
// class Tag {
//   Tag({
//     required this.id,
//     required this.name,
//     required this.slug,
//   });
//
//   int? id;
//   String? name;
//   String? slug;
//
//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//   };
// }*/
