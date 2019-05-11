import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class UserUninitialized extends UserState
    with ElementUninitialized<UserViewModel> {
  UserUninitialized() : super([]);

  @override
  String toString() => '$UserUninitialized { }';
}

class UserLoading extends UserState with ElementLoading<UserViewModel> {
  UserLoading() : super([]);

  @override
  String toString() => '$UserLoading { }';
}

class UserLoaded extends UserState with ElementLoaded<UserViewModel> {
  UserLoaded({UserViewModel user}) : super([user]) {
    this.element = user;
  }

  @override
  String toString() {
    return '$UserLoaded { element: $element }';
  }
}

class UserFailure extends UserState with ElementFailure<UserViewModel> {
  UserFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$UserFailure { error: $error }';
}
