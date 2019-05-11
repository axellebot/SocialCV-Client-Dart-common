import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class AppThemeChanged extends AppEvent {
  final String theme;

  AppThemeChanged({@required this.theme}) : super([theme]);

  @override
  String toString() => '$AppThemeChanged { theme: $theme }';
}
