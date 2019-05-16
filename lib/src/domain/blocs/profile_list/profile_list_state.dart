import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ProfileListState extends Equatable {
  ProfileListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileListUninitialized extends ProfileListState
    with ElementListUninitialized<ProfileViewModel> {}

class ProfileListLoading extends ProfileListState
    with ElementListLoading<ProfileViewModel> {
  ProfileListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ count: $count }';
}

class ProfileListLoaded extends ProfileListState
    with ElementListLoaded<ProfileViewModel> {
  ProfileListLoaded({@required List<ProfileViewModel> profiles})
      : super([profiles]) {
    this.elements = profiles;
  }

  @override
  String toString() => '$runtimeType{ profiles: $elements}';
}

class ProfileListFailure extends ProfileListState
    with ElementListFailure<ProfileViewModel> {
  ProfileListFailure({@required Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ error: $error}';
}
