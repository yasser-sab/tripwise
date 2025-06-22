import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  int id;
  String? name;

  @JsonKey(name: 'photot_uri')
  final String? phototUri;

  City({
    required this.id,
     this.name,
     this.phototUri,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
