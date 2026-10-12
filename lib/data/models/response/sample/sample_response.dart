import 'package:json_annotation/json_annotation.dart';

part 'sample_response.g.dart';

@JsonSerializable()
class SampleItemResponse {
  const SampleItemResponse({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
  });

  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;

  factory SampleItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SampleItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SampleItemResponseToJson(this);
}
