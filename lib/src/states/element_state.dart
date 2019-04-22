import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

abstract class ElementState<T extends ElementDataModel> extends Equatable {
  ElementState([List props = const []]) : super(props);

  @override
  String toString() => 'ElementState<$T>';
}

class ElementUninitialized<T extends ElementDataModel> extends ElementState<T> {
  ElementUninitialized() : super();

  @override
  String toString() => 'ElementUninitialized<$T>';
}

class ElementLoading<T extends ElementDataModel> extends ElementState<T> {
  ElementLoading() : super();

  @override
  String toString() => 'ElementLoading<$T>';
}

class ElementLoaded<T extends ElementDataModel> extends ElementState<T> {
  ElementLoaded({@required this.element}) : super([element]);

  T element;

  @override
  String toString() => 'ElementLoaded<$T> { element: $element }';
}

class ElementFailure<T extends ElementDataModel> extends ElementState<T> {
  ElementFailure({@required this.error}) : super([error]);

  Error error;

  @override
  String toString() => 'ElementFailure<$T> { error: $error }';
}
