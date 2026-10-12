import 'dart:io';

import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import 'data/data_source/remote/sample/sample_api.dart';
import 'data/data_source/remote/sample/sample_remote_data_source.dart';
import 'data/repositories/sample/sample_repository_impl.dart';
import 'domains/repositories/sample/sample_repository.dart';
import 'domains/usecases/sample/create_sample_item_usecase.dart';
import 'domains/usecases/sample/get_sample_items_usecase.dart';

/// Application dependency composition.
///
/// Keep registrations grouped by responsibility so a module can be added or
/// removed without turning this file into one long dependency graph:
/// core services → data sources → repositories → use cases.
final class DependencyInjection {
  DependencyInjection._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Di().init();
    await _registerPlatformInfo();
    _registerCoreServices();
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();

    _initialized = true;
  }

  static Future<void> _registerPlatformInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      getIt.registerSingleton<AndroidDeviceInfo>(androidDeviceInfo);
      return;
    }

    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      getIt.registerSingleton<IosDeviceInfo>(iosDeviceInfo);
    }
  }

  static void _registerCoreServices() {
    getIt.registerSingleton<AppEnvironment>(AppEnvironment.current);
    getIt.registerLazySingleton<AppBaseRepo>(AppBaseRepo.new);
    getIt.registerLazySingleton<Dio>(() => getIt<AppBaseRepo>().client);
  }

  static void _registerDataSources() {
    getIt.registerLazySingleton<SampleApi>(() => SampleApi(getIt<Dio>()));
    getIt.registerLazySingleton<SampleRemoteDataSource>(
      () => SampleRemoteDataSource(getIt<SampleApi>()),
    );
  }

  static void _registerRepositories() {
    getIt.registerLazySingleton<SampleRepository>(() {
      return SampleRepositoryImpl(getIt<SampleRemoteDataSource>());
    });
  }

  static void _registerUseCases() {
    getIt.registerLazySingleton<GetSampleItemsUseCase>(
      () => GetSampleItemsUseCase(getIt<SampleRepository>()),
    );
    getIt.registerLazySingleton<CreateSampleItemUseCase>(
      () => CreateSampleItemUseCase(getIt<SampleRepository>()),
    );
  }
}
