import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class AppThemeChanged extends AppEvent {
  AppThemeChanged({@required this.theme}) : super([theme]);

  String theme;

  @override
  String toString() => 'AppThemeChanged { theme: $theme }';
}
