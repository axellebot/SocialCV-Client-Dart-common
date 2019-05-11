import 'package:social_cv_client_dart_common/models.dart';

mixin ElementListUninitialized<T extends ElementViewModel> {
  @override
  String toString() => '$ElementListUninitialized<$T>';
}

mixin ElementListLoading<T extends ElementViewModel> {
  int count;

  @override
  String toString() => '$ElementListLoading<$T>';
}

mixin ElementListLoaded<T extends ElementViewModel> {
  List<T> elements;

  @override
  String toString() => '$ElementListLoaded<$T> { elements: $elements }';
}

mixin ElementListFailure<T extends ElementViewModel> {
  Error error;

  @override
  String toString() => '$ElementListFailure<$T> { error: $error }';
}
