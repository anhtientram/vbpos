import 'package:core/core.dart';

import '../../entities/sample/sample_entities.dart';

abstract interface class SampleRepository {
  AsyncEither<List<SampleItemEntities>> getItems();

  AsyncEither<SampleItemEntities> createItem(CreateSampleItemParams params);
}
