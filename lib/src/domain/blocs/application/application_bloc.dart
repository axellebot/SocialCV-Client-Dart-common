import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ThemeType {
  static const String LIGHT = 'THEME_LIGHT';
  static const String DARK = 'THEME_DARK';
}

/// Business Logic Component for Application behaviors
class AppBloc extends Bloc<AppEvent, AppState> {
  final String _tag = 'AppBloc';

  final AppPreferencesRepository appPreferencesRepository;

  AppBloc({
    @required this.appPreferencesRepository,
  })  : assert(
          appPreferencesRepository != null,
          'No $AppPreferencesRepository given',
        ),
        super();

  @override
  AppState get initialState => AppInitialized.defaultValues();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is AppConfigured) {
      yield* _mapAppConfiguredToState(event);
    } else if (event is AppThemeChanged) {
      yield* _mapAppThemeChangedToState(event);
    }
  }

  /// Map [AppThemeChanged] to [AppState]
  ///
  /// ```dart
  /// yield* _mapAppThemeChangedToState(event);
  /// ```
  Stream<AppState> _mapAppThemeChangedToState(AppThemeChanged event) async* {
    try {
      yield AppLoading();
      await appPreferencesRepository.setAppTheme(event.theme);
      yield AppInitialized(theme: event.theme);
    } catch (error) {
      yield AppFailure(error: error);
    }
  }

  /// Map [AppConfigured] to [AppState]
  ///
  /// ```dart
  /// yield* _mapAppConfiguredToState(event);
  /// ```
  Stream<AppState> _mapAppConfiguredToState(AppConfigured event) async* {
    try {
      yield AppLoading();
      final theme =
          await appPreferencesRepository.getAppTheme() ?? ThemeType.LIGHT;
      yield AppInitialized(theme: theme);
    } catch (error) {
      yield AppFailure(error: error);
    }
  }
}
