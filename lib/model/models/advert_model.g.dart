/*
part of 'advert_model.dart';

AdvertismentModel advertModelFromJson(Map<String, dynamic> json){
      return AdvertismentModel(
            id: json["id"],
            timestamp: json["timestamp"],
            title: json["title"],
            mediaUrLs: List<String>.from(json["mediaURLs"].map((x) => x)),
            shortText: json["shortText"],
            fullText: json["fullText"],
            category: json["category"],
            offerCategories: List<dynamic>.from(json["offerCategories"].map((x) => x)),
            format: json["format"],
            clickRedirectLink: json["clickRedirectLink"],
            clickRedirectTo: json["clickRedirectTo"],
            cardWidth: json["cardWidth"],
            cardHeight: json["cardHeight"],
            regularPrice: json["regularPrice"],
            salePrice: json["salePrice"],
            installmentPrice: json["installmentPrice"],
            stockStatus: json["stockStatus"],
            author: json["author"],
            tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
            dateCreated: json["dateCreated"],
      );
}

Map<String, dynamic> advertModelToJson(AdvertismentModel instance)=><String , dynamic>{
      "id": instance.id,
      "timestamp": instance.timestamp,
      "title": instance.title,
      "mediaURLs": List<dynamic>.from(instance.mediaUrLs!.map((x) => x)),
      "shortText": instance.shortText,
      "fullText": instance.fullText,
      "category": instance.category,
      "offerCategories": List<dynamic>.from(instance.offerCategories!.map((x) => x)),
      "format": instance.format,
      "clickRedirectLink": instance.clickRedirectLink,
      "clickRedirectTo": instance.clickRedirectTo,
      "cardWidth": instance.cardWidth,
      "cardHeight": instance.cardHeight,
      "regularPrice": instance.regularPrice,
      "salePrice": instance.salePrice,
      "installmentPrice": instance.installmentPrice,
      "stockStatus": instance.stockStatus,
      "author": instance.author,
      "tags": List<Tag>.from(instance.tags!.map((x) => x.toJson())),
      "dateCreated": instance.dateCreated,

};*/
