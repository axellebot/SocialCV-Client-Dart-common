import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';

class ThemeType {
  static const String LIGHT = "THEME_LIGHT";
  static const String DARK = "THEME_DARK";
}

/// Business Logic Component for Application behavior and configurations
class AppBloc extends BlocBase {
  final String _TAG = "AppBloc";

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
  void dispose() {
    _themeController.close();
  }
}
