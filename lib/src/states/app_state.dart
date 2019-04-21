import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class AppUninitialized extends AppState {
  AppUninitialized() : super();

  @override
  String toString() => 'AppUninitialized';
}

class AppInitialized extends AppState {
  AppInitialized() : super();

  @override
  String toString() => 'AppInitialized';
}

class AppLoading extends AppState {
  AppLoading() : super();

  @override
  String toString() => 'AppLoading';
}
