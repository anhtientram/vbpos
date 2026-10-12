import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:core/core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'core/themes/app_theme.dart';
import 'domains/usecases/sample/create_sample_item_usecase.dart';
import 'domains/usecases/sample/get_sample_items_usecase.dart';
import 'l10n/gen/l10n.dart';
import 'presentations/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({required this.environment, super.key})
    : router = AppNavigator.configure(
        getSampleItems: getIt<GetSampleItemsUseCase>(),
        createSampleItem: getIt<CreateSampleItemUseCase>(),
        environmentName: environment.name,
      );

  final AppEnvironment environment;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: environment.appName,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (context, child) {
          final easyLoadingChild = EasyLoading.init()(context, child);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: AppSystemUi.overlayLight,
            child: MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1)),
              child: easyLoadingChild,
            ),
          );
        },
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalization.delegate.supportedLocales,
      ),
    );
  }
}
