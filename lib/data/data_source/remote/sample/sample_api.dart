import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../api_endpoints.dart';
import '../../../models/request/sample/sample_request.dart';
import '../../../models/response/sample/sample_response.dart';

part 'sample_api.g.dart';

@RestApi()
abstract class SampleApi {
  factory SampleApi(Dio dio, {String? baseUrl}) = _SampleApi;

  @GET(ApiEndpoints.sampleItems)
  Future<List<SampleItemResponse>> getItems();

  @POST(ApiEndpoints.sampleItems)
  Future<SampleItemResponse> createItem(
    @Body() CreateSampleItemRequest request,
  );
}
