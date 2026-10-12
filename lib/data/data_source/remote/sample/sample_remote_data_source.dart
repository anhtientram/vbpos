import 'package:core/core.dart';

import '../../../models/request/sample/sample_request.dart';
import '../../../models/response/sample/sample_response.dart';
import 'sample_api.dart';

class SampleRemoteDataSource {
  const SampleRemoteDataSource(this._api);

  final SampleApi _api;

  AsyncEither<List<SampleItemResponse>> getItems() =>
      ResultUtils.guardRemote(_api.getItems);

  AsyncEither<SampleItemResponse> createItem(CreateSampleItemRequest request) =>
      ResultUtils.guardRemote(() => _api.createItem(request));
}
