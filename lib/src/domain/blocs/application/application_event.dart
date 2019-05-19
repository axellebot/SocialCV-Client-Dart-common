import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// [AppEvent] that must be dispatch to [AppBloc]
abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AppConfigured extends AppEvent {}

class AppThemeChanged extends AppEvent {
  final String theme;

  AppThemeChanged({@required this.theme}) : super([theme]);

  @override
  String toString() => '$runtimeType{ theme: $theme }';
}
