import '../../../../domains/entities/sample/sample_entities.dart';
import 'sample_model.dart';

abstract final class SamplePresentationsMapper {
  static SampleItemModel toItemModel(SampleItemEntities entity) {
    return SampleItemModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }
}
