import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileInitialized extends ProfileEvent
    with ElementInitialized<ProfileViewModel> {
  ProfileInitialized({String profileId, ProfileViewModel profile})
      : assert(
          profileId != null && profile == null,
          '$ProfileInitialized must be created with an $ProfileViewModel or its ID',
        ),
        assert(
          profileId == null && profile != null,
          '$ProfileInitialized must be created with an $ProfileViewModel or its ID',
        ),
        super([profileId, profile]) {
    this.elementId = profileId;
    this.element = profile;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class ProfileRefresh extends ProfileEvent
    with ElementRefresh<ProfileViewModel> {}
