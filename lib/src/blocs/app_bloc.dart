import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/events/app_event.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';
import 'package:social_cv_client_dart_common/src/states/app_state.dart';

class ThemeType {
  static const String LIGHT = 'THEME_LIGHT';
  static const String DARK = 'THEME_DARK';
}

/// Business Logic Component for Application behavior and configurations
class AppBloc extends Bloc<AppEvent, AppState> {
  final String _TAG = 'AppBloc';

  AppBloc({
    @required this.preferencesRepository,
  })  : assert(preferencesRepository != null),
        super() {
    preferencesRepository.getAppTheme().then(_themeController.add);
  }

  final PreferencesRepository preferencesRepository;

  // Rx Variables
  final _themeController = BehaviorSubject<String>();

  // Streams
  Observable<String> get themeStream => _themeController.stream;

  /* Functions */
  // Human functions
  Future<void> setTheme(String theme) async {
    print('$_TAG:setTheme->$theme');
    _themeController.add(theme);
    preferencesRepository.setAppTheme(theme);
  }

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppThemeChanged) {
      yield AppLoading();
      preferencesRepository.setAppTheme(event.theme);
      yield AppInitialized();
    }
  }
}
