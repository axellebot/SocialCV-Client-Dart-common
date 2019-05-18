import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupUninitialized extends GroupState
    with ElementUninitialized<GroupViewModel> {}

class GroupLoading extends GroupState with ElementLoading<GroupViewModel> {}

class GroupLoaded extends GroupState with ElementLoaded<GroupViewModel> {
  GroupLoaded({GroupViewModel group}) : super([group]) {
    this.element = group;
  }

  @override
  String toString() {
    return '$runtimeType{ group: $element }';
  }
}

class GroupFailure extends GroupState with ElementFailure<GroupViewModel> {
  GroupFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType { error: ${error.runtimeType} }';
}
