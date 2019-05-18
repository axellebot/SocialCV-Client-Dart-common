import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ThemeType {
  static const String LIGHT = 'THEME_LIGHT';
  static const String DARK = 'THEME_DARK';
}

/// Business Logic Component for Application behavior and configurations
class AppBloc extends Bloc<AppEvent, AppState> {
  final String _tag = 'AppBloc';

  final PreferencesRepository preferencesRepository;

  AppBloc({
    @required this.preferencesRepository,
  })  : assert(
          preferencesRepository != null,
          'No $PreferencesRepository given',
        ),
        super();

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print('$_tag:$mapEventToState($event)');

    if (event is AppThemeChanged) {
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
      preferencesRepository.setAppTheme(event.theme);
      yield AppInitialized(theme: event.theme);
    } catch (error) {
      yield AppFailure(error: error);
    }
  }
}
