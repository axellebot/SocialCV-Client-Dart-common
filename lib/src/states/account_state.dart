import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

abstract class AccountState extends Equatable {
  AccountState([List props = const []]) : super(props);
}

class AccountUninitialized extends AccountState {
  @override
  String toString() => 'AccountUninitialized';
}

class AccountLoaded extends AccountState {
  UserDataModel userModel;
  List<ProfileDataModel> profileList;

  AccountLoaded({
    @required this.userModel,
    @required this.profileList,
  }) : super([userModel, profileList]);

  @override
  String toString() =>
      'AccountLoaded { userModel: $userModel, profileList: $profileList }';
}

class AccountFailed extends AccountState {
  final Error error;

  AccountFailed({@required this.error}) : super([error]);

  @override
  String toString() => 'AccountFailed { error: $error }';
}
