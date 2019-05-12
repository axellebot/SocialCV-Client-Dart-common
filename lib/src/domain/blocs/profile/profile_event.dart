import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}

class ProfileInitialized extends ProfileEvent
    with ElementInitialized<ProfileViewModel> {
  ProfileInitialized({String withId, ProfileViewModel withProfile})
      : assert(
            (withId != null && withProfile == null) ||
                (withId == null && withProfile != null),
            '$ProfileInitialized must be created with an $ProfileViewModel or its ID'),
        super([withId, withProfile]) {
    this.elementId = withId;
    this.element = withProfile;
  }

  @override
  String toString() =>
      '$ProfileInitialized { id: $elementId, element: $element }';
}

class ProfileRefresh extends ProfileEvent
    with ElementRefresh<ProfileViewModel> {
  ProfileRefresh() : super([]);

  @override
  String toString() => '$ProfileRefresh {}';
}
