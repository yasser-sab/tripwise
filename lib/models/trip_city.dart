import 'package:json_annotation/json_annotation.dart';
import 'package:tourism/models/city.dart';

part 'trip_city.g.dart';

@JsonSerializable()
class TripCity {

  @JsonKey(name :"city_trip_id")
  int cityTripId;

  @JsonKey(name :"trip_day")
  int tripDay;

  City city;

  TripCity({
    required this.cityTripId,
    required this.tripDay,
    required this.city,
  });

  factory TripCity.fromJson(Map<String, dynamic> json) => _$TripCityFromJson(json);

  Map<String, dynamic> toJson() => _$TripCityToJson(this);
}
