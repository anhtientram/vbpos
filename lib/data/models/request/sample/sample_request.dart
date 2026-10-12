import 'package:json_annotation/json_annotation.dart';

part 'sample_request.g.dart';

@JsonSerializable()
class CreateSampleItemRequest {
  const CreateSampleItemRequest({required this.name, this.description});

  final String name;
  final String? description;

  factory CreateSampleItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSampleItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSampleItemRequestToJson(this);
}
