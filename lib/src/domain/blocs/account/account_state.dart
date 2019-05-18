import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/ui/models/profile_model.dart';
import 'package:social_cv_client_dart_common/src/ui/models/user_model.dart';

abstract class AccountState extends Equatable {
  AccountState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AccountUninitialized extends AccountState {}

class AccountLoaded extends AccountState {
  UserViewModel user;
  List<ProfileViewModel> profiles;

  AccountLoaded({
    @required this.user,
    @required this.profiles,
  }) : super([user, profiles]);

  @override
  String toString() => '$runtimeType{ userModel: $user, profiles: $profiles }';
}

class AccountFailed extends AccountState {
  final Error error;

  AccountFailed({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: $error }';
}
