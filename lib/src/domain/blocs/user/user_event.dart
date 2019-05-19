import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

/// [UserEvent] that must be dispatch to [UserBloc]
abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class UserInitialized extends UserEvent with ElementInitialized<UserViewModel> {
  UserInitialized({String userId, UserViewModel user})
      : assert(userId != null && user == null),
        assert(userId == null && user != null),
        super([userId, user]) {
    this.elementId = userId;
    this.element = user;
  }

  @override
  String toString() => '$runtimeType{ userId: $elementId, user: $element }';
}

class UserRefresh extends UserEvent with ElementRefresh<UserViewModel> {}
