import 'package:core/core.dart';

import '../../entities/sample/sample_entities.dart';
import '../../repositories/sample/sample_repository.dart';

class CreateSampleItemUseCase {
  const CreateSampleItemUseCase(this._repository);

  final SampleRepository _repository;

  AsyncEither<SampleItemEntities> call(CreateSampleItemParams params) {
    return _repository.createItem(params);
  }
}
