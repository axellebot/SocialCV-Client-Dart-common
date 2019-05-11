import 'package:social_cv_client_dart_common/models.dart';

mixin ElementUninitialized<T extends ElementViewModel> {
  @override
  String toString() => '$ElementUninitialized<$T>';
}

mixin ElementLoading<T extends ElementViewModel> {
  @override
  String toString() => '$ElementLoading<$T>';
}

mixin ElementLoaded<T extends ElementViewModel> {
  T element;

  @override
  String toString() => '$ElementLoaded<$T> { element: $element }';
}

mixin ElementFailure<T extends ElementViewModel> {
  Error error;

  @override
  String toString() => '$ElementFailure<$T> { error: $error }';
}
