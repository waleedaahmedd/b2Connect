// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOffers _$GetOffersFromJson(Map<String, dynamic> json) => GetOffers(
      offers: (json['offers'] as List<dynamic>).map((e) => OffersList.fromJson(e as Map<String, dynamic>)).toList(),
      offerCount: json['offerCount'] as int,
      filterMeta: FilterMeta.fromJson(json['filterMeta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOffersToJson(GetOffers instance) => <String, dynamic>{
      'offers': instance.offers,
      'offerCount': instance.offerCount,
      'filterMeta': instance.filterMeta,
    };
