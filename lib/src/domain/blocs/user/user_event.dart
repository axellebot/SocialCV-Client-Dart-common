import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class UserInitialized extends UserEvent with ElementInitialized<UserViewModel> {
  UserInitialized({String withId, UserViewModel withUser})
      : assert(withId != null && withUser == null),
        assert(withId == null && withUser != null),
        super([withId, withUser]) {
    this.elementId = withId;
    this.element = withUser;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class UserRefresh extends UserEvent with ElementRefresh<UserViewModel> {}
