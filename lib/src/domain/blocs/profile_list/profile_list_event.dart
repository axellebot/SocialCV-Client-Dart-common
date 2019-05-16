import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class ProfileListEvent extends Equatable {
  ProfileListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileListInitialized extends ProfileListEvent
    with ElementListInitialized<ProfileViewModel> {
  ProfileListInitialized({
    String withParentId,
    String withOwnerId,
    Cursor cursor,
  })  : assert(withParentId != null && withOwnerId == null),
        assert(withParentId == null && withOwnerId != null),
        super([withParentId, withOwnerId]) {
    this.parentId = withParentId;
    this.ownerId = withOwnerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$runtimeType{ parentId: $parentId, ownerId: $ownerId, cursor: $cursor }';
}

class ProfileListRefresh extends ProfileListEvent
    with ElementListRefresh<ProfileViewModel> {}

class ProfileListLoadMore extends ProfileListEvent
    with ElementListLoadMore<ProfileViewModel> {
  ProfileListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$runtimeType{ cursor: $cursor }';
}
