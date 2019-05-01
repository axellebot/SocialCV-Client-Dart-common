import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ElementListState<T extends ElementViewModel> extends Equatable {
  ElementListState([List props = const []]) : super(props);

  @override
  String toString() => 'ElementListState<$T>';
}

class ElementListUninitialized<T extends ElementViewModel>
    extends ElementListState<T> {
  ElementListUninitialized() : super();

  @override
  String toString() => 'ElementListUninitialized<$T>';
}

class ElementListLoading<T extends ElementViewModel>
    extends ElementListState<T> {
  ElementListLoading() : super();

  @override
  String toString() => 'ElementListLoading<$T>';
}

class ElementListLoaded<T extends ElementViewModel>
    extends ElementListState<T> {
  final List<T> elements;

  ElementListLoaded({@required this.elements}) : super([elements]);

  @override
  String toString() => 'ElementListLoaded<$T> { elements: $elements }';
}

class ElementListFailure<T extends ElementViewModel>
    extends ElementListState<T> {
  final Error error;

  ElementListFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ElementListFailure<$T> { error: $error }';
}
