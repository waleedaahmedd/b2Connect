
class Blogs {
  int? id;
  int? timestamp;
  String? title;
  List<String>? mediaURLs;
  String? shortText;
  String? fullText;
  String? category;
  /*List<Null>? offerCategories;*/
  String? format;
  String? clickRedirectLink;
  int? clickRedirectTo;
  int? cardWidth;
  int? cardHeight;
  double? regularPrice;
  double? salePrice;
  double? installmentPrice;
  String? stockStatus;
  String? author;
  List<Tags>? tags;
  int? dateCreated;

  Blogs(
      {this.id,
        this.timestamp,
        this.title,
        this.mediaURLs,
        this.shortText,
        this.fullText,
        this.category,
       /* this.offerCategories,*/
        this.format,
        this.clickRedirectLink,
        this.clickRedirectTo,
        this.cardWidth,
        this.cardHeight,
        this.regularPrice,
        this.salePrice,
        this.installmentPrice,
        this.stockStatus,
        this.author,
        this.tags,
        this.dateCreated});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
    title = json['title'];
    mediaURLs = json['mediaURLs'].cast<String>();
    shortText = json['shortText'];
    fullText = json['fullText'];
    category = json['category'];
    /*if (json['offerCategories'] != null) {
      offerCategories = <Null>[];
      json['offerCategories'].forEach((v) {
        offerCategories!.add(new Null.fromJson(v));
      });
    }*/
    format = json['format'];
    clickRedirectLink = json['clickRedirectLink'];
    clickRedirectTo = json['clickRedirectTo'];
    cardWidth = json['cardWidth'];
    cardHeight = json['cardHeight'];
    regularPrice = json['regularPrice'];
    salePrice = json['salePrice'];
    installmentPrice = json['installmentPrice'];
    stockStatus = json['stockStatus'];
    author = json['author'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    dateCreated = json['dateCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['title'] = this.title;
    data['mediaURLs'] = this.mediaURLs;
    data['shortText'] = this.shortText;
    data['fullText'] = this.fullText;
    data['category'] = this.category;
 /*   if (this.offerCategories != null) {
      data['offerCategories'] =
          this.offerCategories!.map((v) => v.toJson()).toList();
    }*/
    data['format'] = this.format;
    data['clickRedirectLink'] = this.clickRedirectLink;
    data['clickRedirectTo'] = this.clickRedirectTo;
    data['cardWidth'] = this.cardWidth;
    data['cardHeight'] = this.cardHeight;
    data['regularPrice'] = this.regularPrice;
    data['salePrice'] = this.salePrice;
    data['installmentPrice'] = this.installmentPrice;
    data['stockStatus'] = this.stockStatus;
    data['author'] = this.author;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['dateCreated'] = this.dateCreated;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  String? slug;

  Tags({this.id, this.name, this.slug});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}