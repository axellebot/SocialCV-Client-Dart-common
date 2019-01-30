import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/repositories/preferences_repository.dart';

class THEME {
  static const String LIGHT = "THEME_LIGHT";
  static const String DARK = "THEME_DARK";
}

const String _TAG = "ApplicationBloc";

class ApplicationBloc extends BlocBase {
  ApplicationBloc({
    this.preferencesRepository,
  })
      : assert(preferencesRepository != null),
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
  void setTheme(String theme) {
    print('$_TAG:setTheme->$theme');
    _themeController.add(theme);
    preferencesRepository.setAppTheme(theme);
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
