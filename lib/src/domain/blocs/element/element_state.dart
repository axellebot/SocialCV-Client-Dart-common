import 'package:social_cv_client_dart_common/models.dart';

mixin ElementUninitialized<T extends ElementViewModel> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoading<T extends ElementViewModel> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoaded<T extends ElementViewModel> {
  T element;

  @override
  String toString() => '$runtimeType{ element: $element }';
}

mixin ElementFailure<T extends ElementViewModel> {
  Error error;

  @override
  String toString() => '$runtimeType{ error: $error }';
}
