import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AppInitialized extends AppState {
  final String theme;

  AppInitialized({this.theme = ThemeType.LIGHT}) : super([theme]);

  AppInitialized.defaultValues() : this.theme = ThemeType.LIGHT;

  @override
  String toString() => '$runtimeType{ theme: $theme }';
}

class AppFailure extends AppState {
  final Error error;

  AppFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: ${error.runtimeType} }';
}

class AppLoading extends AppState {}
