import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AppUninitialized extends AppState {
  final String theme = ThemeType.LIGHT;

  AppUninitialized() : super();

  @override
  String toString() => '$runtimeType{ theme: $theme }';
}

class AppInitialized extends AppState {
  final String theme;

  AppInitialized({@required this.theme}) : super([theme]);

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
