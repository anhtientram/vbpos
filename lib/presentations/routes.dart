import 'package:go_router/go_router.dart';

import '../domains/usecases/sample/create_sample_item_usecase.dart';
import '../domains/usecases/sample/get_sample_items_usecase.dart';
import 'pages/sample/sample_screen.dart';

enum Routes {
  sample('/sample');

  const Routes(this.path);

  final String path;
}

/// App-owned router. Feature screens are constructed at the route boundary;
/// routes do not contain DTOs or repository wiring.
final class AppRouter {
  AppRouter._();

  static GoRouter create({
    required GetSampleItemsUseCase getSampleItems,
    required CreateSampleItemUseCase createSampleItem,
    required String environmentName,
  }) {
    return GoRouter(
      initialLocation: Routes.sample.path,
      routes: [
        GoRoute(
          path: Routes.sample.path,
          builder: (context, state) => SampleScreen(
            getSampleItems: getSampleItems,
            createSampleItem: createSampleItem,
            environmentName: environmentName,
          ),
        ),
      ],
    );
  }
}

/// Stable navigation facade for feature code and future modules.
final class AppNavigator {
  AppNavigator._();

  static GoRouter? _router;

  static GoRouter get router {
    final value = _router;
    if (value == null) {
      throw StateError('AppNavigator has not been configured');
    }
    return value;
  }

  static GoRouter configure({
    required GetSampleItemsUseCase getSampleItems,
    required CreateSampleItemUseCase createSampleItem,
    required String environmentName,
  }) {
    return _router = AppRouter.create(
      getSampleItems: getSampleItems,
      createSampleItem: createSampleItem,
      environmentName: environmentName,
    );
  }

  static void go(Routes route, {Object? extra}) {
    router.go(route.path, extra: extra);
  }

  static Future<T?> push<T extends Object?>(Routes route, {Object? extra}) {
    return router.push<T>(route.path, extra: extra);
  }

  static void pop<T extends Object?>([T? result]) {
    router.pop(result);
  }
}
