import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class PartState extends Equatable {
  PartState([List props = const []]) : super(props);
}

class PartUninitialized extends PartState
    with ElementUninitialized<PartViewModel> {
  PartUninitialized() : super([]);

  @override
  String toString() => '$PartUninitialized {}';
}

class PartLoading extends PartState with ElementLoading<PartViewModel> {
  PartLoading() : super([]);

  @override
  String toString() => '$PartLoading {}';
}

class PartLoaded extends PartState with ElementLoaded<PartViewModel> {
  PartLoaded({PartViewModel part}) : super([part]) {
    this.element = part;
  }

  @override
  String toString() {
    return '$PartLoaded { element: $element }';
  }
}

class PartFailure extends PartState with ElementFailure<PartViewModel> {
  PartFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$PartFailure { error: $error }';
}
