import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/bloc.dart';
import 'package:social_cv_client_dart_common/domain.dart';

/// [GroupEvent] that must be dispatch to [GroupBloc]

abstract class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupInitialized extends GroupEvent with ElementInitialized<GroupEntity> {
  GroupInitialized({String groupId, GroupEntity group})
      : assert(
          groupId != null && group == null,
          '$GroupInitialized must be created with a $GroupEntity or its ID',
        ),
        assert(
          groupId == null && group != null,
          '$GroupInitialized must be created with a $GroupEntity or its ID',
        ),
        super([groupId, group]) {
    this.elementId = groupId;
    this.element = group;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class GroupRefresh extends GroupEvent with ElementRefresh<GroupEntity> {}