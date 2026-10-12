import 'package:core/core.dart';

import '../../../domains/entities/sample/sample_entities.dart';
import '../../../domains/repositories/sample/sample_repository.dart';
import '../../data_source/remote/sample/sample_remote_data_source.dart';
import '../../mapper/sample/sample_mapper.dart';

class SampleRepositoryImpl implements SampleRepository {
  const SampleRepositoryImpl(this._remoteDataSource);

  final SampleRemoteDataSource _remoteDataSource;

  @override
  AsyncEither<List<SampleItemEntities>> getItems() async {
    final result = await _remoteDataSource.getItems();
    return result.map((items) => items.map(SampleMapper.toEntities).toList());
  }

  @override
  AsyncEither<SampleItemEntities> createItem(
    CreateSampleItemParams params,
  ) async {
    final result = await _remoteDataSource.createItem(
      SampleMapper.toCreateRequest(params),
    );
    return result.map(SampleMapper.toEntities);
  }
}
