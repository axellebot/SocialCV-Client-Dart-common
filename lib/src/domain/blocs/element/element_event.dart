import 'package:social_cv_client_dart_common/models.dart';

mixin ElementInitialized<T extends ElementViewModel> {
  String elementId;
  T element;

  @override
  String toString() =>
      '$ElementInitialized<$T> { id: $elementId, element: $element }';
}

mixin ElementRefresh<T extends ElementViewModel> {
  @override
  String toString() => '$ElementRefresh{}';
}
