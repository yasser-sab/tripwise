import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;

  @JsonKey(name: "user_id")
  int userId;

  Trip({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.userId,
  });

    factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
