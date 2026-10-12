import 'package:core/core.dart';

import '../../entities/sample/sample_entities.dart';
import '../../repositories/sample/sample_repository.dart';

class GetSampleItemsUseCase {
  const GetSampleItemsUseCase(this._repository);

  final SampleRepository _repository;

  AsyncEither<List<SampleItemEntities>> call() => _repository.getItems();
}
