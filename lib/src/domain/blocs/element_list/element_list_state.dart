import 'package:social_cv_client_dart_common/models.dart';

mixin ElementListUninitialized<T extends ElementViewModel> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementListLoading<T extends ElementViewModel> {
  int count;

  @override
  String toString() => '$runtimeType{ count: $count }';
}

mixin ElementListLoaded<T extends ElementViewModel> {
  List<T> elements;

  @override
  String toString() => '$runtimeType{ elements: $elements }';
}

mixin ElementListFailure<T extends ElementViewModel> {
  Error error;

  @override
  String toString() => '$runtimeType{ error: $error }';
}
