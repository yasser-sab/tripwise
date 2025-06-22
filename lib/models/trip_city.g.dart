// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripCity _$TripCityFromJson(Map<String, dynamic> json) => TripCity(
      cityTripId: (json['city_trip_id'] as num).toInt(),
      tripDay: (json['trip_day'] as num).toInt(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripCityToJson(TripCity instance) => <String, dynamic>{
      'city_trip_id': instance.cityTripId,
      'trip_day': instance.tripDay,
      'city': instance.city,
    };
