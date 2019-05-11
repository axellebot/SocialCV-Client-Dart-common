import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);
}

class GroupUninitialized extends GroupState
    with ElementUninitialized<GroupViewModel> {
  GroupUninitialized() : super([]);

  @override
  String toString() => '$GroupUninitialized { }';
}

class GroupLoading extends GroupState with ElementLoading<GroupViewModel> {
  GroupLoading() : super([]);

  @override
  String toString() => '$GroupLoading { }';
}

class GroupLoaded extends GroupState with ElementLoaded<GroupViewModel> {
  GroupLoaded({GroupViewModel group}) : super([group]) {
    this.element = group;
  }

  @override
  String toString() {
    return '$GroupLoaded { element: $element }';
  }
}

class GroupFailure extends GroupState with ElementFailure<GroupViewModel> {
  GroupFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$GroupFailure { error: $error }';
}
