import '../../../domains/entities/sample/sample_entities.dart';
import '../../models/request/sample/sample_request.dart';
import '../../models/response/sample/sample_response.dart';

abstract final class SampleMapper {
  static CreateSampleItemRequest toCreateRequest(
    CreateSampleItemParams params,
  ) {
    return CreateSampleItemRequest(
      name: params.name,
      description: params.description,
    );
  }

  static SampleItemEntities toEntities(SampleItemResponse response) {
    return SampleItemEntities(
      id: response.id,
      name: response.name,
      description: response.description,
      createdAt: response.createdAt,
    );
  }
}
