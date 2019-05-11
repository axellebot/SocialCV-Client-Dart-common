import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class GroupEvent extends Equatable {
  GroupEvent([List props = const []]) : super(props);
}

class GroupInitialized extends GroupEvent
    with ElementInitialized<GroupViewModel> {
  GroupInitialized({String withId, GroupViewModel withGroup})
      : assert(withId != null || withGroup != null,
            '$GroupInitialized must be created with a $String ID or a $GroupViewModel'),
        super([withId, withGroup]) {
    this.elementId = withId;
    this.element = withGroup;
  }

  @override
  String toString() => 'GroupInitialized { id: $elementId, element: $element }';
}

class GroupRefresh extends GroupEvent with ElementRefresh<GroupViewModel> {
  GroupRefresh() : super([]);

  @override
  String toString() => '$GroupRefresh {}';
}
