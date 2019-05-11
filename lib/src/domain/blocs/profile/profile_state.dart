import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class ProfileUninitialized extends ProfileState
    with ElementUninitialized<ProfileViewModel> {
  ProfileUninitialized() : super([]);

  @override
  String toString() => '$ProfileUninitialized {}';
}

class ProfileLoading extends ProfileState with ElementLoading<ProfileViewModel> {
  ProfileLoading() : super([]);

  @override
  String toString() => '$ProfileLoading {}';
}

class ProfileLoaded extends ProfileState with ElementLoaded<ProfileViewModel> {
  ProfileLoaded({ProfileViewModel profile}) : super([profile]) {
    this.element = profile;
  }

  @override
  String toString() {
    return '$ProfileLoaded { element: $element }';
  }
}

class ProfileFailure extends ProfileState with ElementFailure<ProfileViewModel> {
  ProfileFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$ProfileFailure { error: $error }';
}
