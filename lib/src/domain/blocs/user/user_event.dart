import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class UserInitialized extends UserEvent with ElementInitialized<UserViewModel> {
  UserInitialized({String withId, UserViewModel withUser})
      : assert(withId != null || withUser != null,
            '$UserInitialized must be created with a $String ID or a $UserViewModel'),
        super([withId, withUser]) {
    this.elementId = withId;
    this.element = withUser;
  }

  @override
  String toString() => '$UserInitialized { id: $elementId, element: $element }';
}

class UserRefresh extends UserEvent with ElementRefresh<UserViewModel> {
  UserRefresh() : super([]);

  @override
  String toString() => '$UserRefresh {}';
}
