import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ElementState<T extends ElementViewModel> extends Equatable {
  ElementState([List props = const []]) : super(props);

  @override
  String toString() => 'ElementState<$T>';
}

class ElementUninitialized<T extends ElementViewModel> extends ElementState<T> {
  ElementUninitialized() : super();

  @override
  String toString() => 'ElementUninitialized<$T>';
}

class ElementLoading<T extends ElementViewModel> extends ElementState<T> {
  ElementLoading() : super();

  @override
  String toString() => 'ElementLoading<$T>';
}

class ElementLoaded<T extends ElementViewModel> extends ElementState<T> {
  ElementLoaded({@required this.element})
      : assert(element != null, 'No $T element given'),
        super([element]);

  final T element;

  @override
  String toString() => 'ElementLoaded<$T> { element: $element }';
}

class ElementFailure<T extends ElementViewModel> extends ElementState<T> {
  ElementFailure({@required this.error}) : super([error]);

  final Error error;

  @override
  String toString() => 'ElementFailure<$T> { error: $error }';
}
