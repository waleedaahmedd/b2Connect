import 'package:json_annotation/json_annotation.dart';

import 'filter_meta_model.dart';
import 'offers_list_model.dart';
part 'get_offers_model.g.dart';
// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class GetOffers {
 List<OffersList> offers;
  int offerCount;
  FilterMeta filterMeta;

  GetOffers({required this.offers, required this.offerCount, required this.filterMeta});

  factory GetOffers.fromJson(Map<String, dynamic> json) => _$GetOffersFromJson(json);
  Map<String, dynamic> toJson() => _$GetOffersToJson(this);
}







