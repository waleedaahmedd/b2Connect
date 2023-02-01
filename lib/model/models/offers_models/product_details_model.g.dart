
//TODO: new installment 6x plan
part of 'product_details_model.dart';
ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json){
  return ProductDetailsModel(
    offer: Offer.fromJson(json["offer"]),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    recommendations: List<Offer>.from(json["recommendations"].map((x) => Offer.fromJson(x))),
  );
}

Map<String, dynamic> _$ProductDetailsModelToJson(ProductDetailsModel instance) => <String, dynamic>{
  "offer": instance.offer.toJson(),
  "attributes": List<dynamic>.from(instance.attributes.map((x) => x.toJson())),
  "recommendations": List<dynamic>.from(instance.recommendations.map((x) => x.toJson())),

};

//attribute
Attribute _$AttributeFromJson(Map<String, dynamic> json){
  return Attribute(
    attributeId: json["attributeId"],
    attributeName: json["attributeName"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );
}

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
  "attributeId": instance.attributeId,
  "attributeName": instance.attributeName,
  "options": List<dynamic>.from(instance.options.map((x) => x.toJson())),

};

//options
Option _$OptionFromJson(Map<String, dynamic> json){
  return Option(
    value: json["value"],
    offerId: json["offerId"],
    stockStatus: json["stockStatus"],
    isCurrent: json["isCurrent"],
  );
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
  "value": instance.value,
  "offerId": instance.offerId,
  "stockStatus": instance.stockStatus,
  "isCurrent": instance.isCurrent,

};


//offer
Offer _$OfferFromJson(Map<String, dynamic> json){
  return Offer(
    id: json["id"],
    timestamp: json["timestamp"],
    name: json["name"],
    images: List<String>.from(json["images"].map((x) => x)),
    shortText: json["shortText"],
    fullText: json["fullText"],
    offerCategories: List<OfferCategory>.from(json["offerCategories"].map((x) => OfferCategory.fromJson(x))),
    link: json["link"],
    cardWidth: json["cardWidth"],
    cardHeight: json["cardHeight"],
    regularPrice: json["regularPrice"],
    salePrice: json["salePrice"],
    installmentPrices: List<InstallmentPrices>.from(json["installmentPrices"].map((x) => InstallmentPrices.fromJson(x))),
    installmentPrice: json["installmentPrice"],
    stockStatus: json["stockStatus"],
    emiEnabled: json["emiEnabled"],
    dateCreated: json["dateCreated"],
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
  "id": instance.id,
  "timestamp": instance.timestamp,
  "name": instance.name,
  "images": List<dynamic>.from(instance.images.map((x) => x)),
  "shortText": instance.shortText,
  "fullText": instance.fullText,
  "offerCategories": List<dynamic>.from(instance.offerCategories.map((x) => x.toJson())),
  "link": instance.link,
  "cardWidth": instance.cardWidth,
  "cardHeight": instance.cardHeight,
  "regularPrice": instance.regularPrice,
  "emiEnabled": instance.emiEnabled,
  "salePrice": instance.salePrice,
  "installmentPrices": List<dynamic>.from(instance.installmentPrices.map((x) => x.toJson())),

  "installmentPrice": instance.installmentPrice,
  "stockStatus": instance.stockStatus,
  "dateCreated": instance.dateCreated,

};


//subCategory
OfferCategory _$OfferCategoryFromJson(Map<String, dynamic> json){
  return OfferCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );
}

Map<String, dynamic> _$OfferCategoryToJson(OfferCategory instance) => <String, dynamic>{
  "id": instance.id,
  "name": instance.name,
  "slug": instance.slug,

};