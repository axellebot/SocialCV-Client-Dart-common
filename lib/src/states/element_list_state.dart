import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

abstract class ElementListState<T extends ElementDataModel> extends Equatable {
  ElementListState([List props = const []]) : super(props);

  @override
  String toString() => 'ElementListState<$T>';
}

class ElementListUninitialized<T extends ElementDataModel>
    extends ElementListState<T> {
  ElementListUninitialized() : super();

  @override
  String toString() => 'ElementListUninitialized<$T>';
}

class ElementListLoading<T extends ElementDataModel>
    extends ElementListState<T> {
  ElementListLoading() : super();

  @override
  String toString() => 'ElementListLoading<$T>';
}

class ElementListLoaded<T extends ElementDataModel>
    extends ElementListState<T> {
  ElementListLoaded({@required this.elements}) : super([elements]);

  List<T> elements;

  @override
  String toString() => 'ElementListLoaded<$T> { elements: $elements }';
}

class ElementListFailure<T extends ElementDataModel>
    extends ElementListState<T> {
  ElementListFailure({@required this.error}) : super([error]);

  Error error;

  @override
  String toString() => 'ElementListFailure<$T> { error: $error }';
}
