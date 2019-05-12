import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class GroupListState extends Equatable {
  GroupListState([List props = const []]) : super(props);
}

class GroupListUninitialized extends GroupListState
    with ElementListUninitialized<GroupViewModel> {
  GroupListUninitialized() : super([]);

  @override
  String toString() => '$GroupListUninitialized {}';
}

class GroupListLoading extends GroupListState
    with ElementListLoading<GroupViewModel> {
  GroupListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$GroupListLoading { count: $count }';
}

class GroupListLoaded extends GroupListState
    with ElementListLoaded<GroupViewModel> {
  GroupListLoaded({@required List<GroupViewModel> groups}) : super([groups]) {
    this.elements = groups;
  }

  @override
  String toString() => '$GroupListLoaded { groups: $elements}';
}

class GroupListFailure extends GroupListState
    with ElementListFailure<GroupViewModel> {
  GroupListFailure({@required Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$GroupListLoaded { error: $error}';
}