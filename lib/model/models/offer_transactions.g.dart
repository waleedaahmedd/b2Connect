
part of 'offer_transactions.dart';

OfferTransactionsModel _$OfferOrderModelFromJson(Map<String, dynamic> json) {
  return OfferTransactionsModel(
    total: json["total"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );
}
Map<String, dynamic> _$OfferOrderModelToJson(OfferTransactionsModel instance) => <String, dynamic>{
  "total": instance.total,
  "items": List<dynamic>.from(instance.items!.map((x) => x.toJson())),
};