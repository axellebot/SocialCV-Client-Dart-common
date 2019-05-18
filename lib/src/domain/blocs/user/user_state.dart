import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class UserUninitialized extends UserState
    with ElementUninitialized<UserViewModel> {}

class UserLoading extends UserState with ElementLoading<UserViewModel> {}

class UserLoaded extends UserState with ElementLoaded<UserViewModel> {
  UserLoaded({UserViewModel user}) : super([user]) {
    this.element = user;
  }

  @override
  String toString() {
    return '$runtimeType{ element: $element }';
  }
}

class UserFailure extends UserState with ElementFailure<UserViewModel> {
  UserFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ error: $error }';
}
