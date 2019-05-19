import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/ui/models/user_model.dart';

abstract class AccountState extends Equatable {
  AccountState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AccountUninitialized extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  UserViewModel user;

  AccountLoaded({
    @required this.user,
  }) : super([user]);

  @override
  String toString() => '$runtimeType{ userModel: $user }';
}

class AccountFailed extends AccountState {
  final Error error;

  AccountFailed({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: $error }';
}
