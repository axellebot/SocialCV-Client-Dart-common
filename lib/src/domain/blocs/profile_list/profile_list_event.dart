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
    String parentUserId,
    String ownerId,
    Cursor cursor,
  })  : assert(
          parentUserId != null && ownerId == null,
          '$ProfileListInitialized must be created with a parentId or an ownerId',
        ),
        assert(
          parentUserId == null && ownerId != null,
          '$ProfileListInitialized must be created with a parentId or an ownerId',
        ),
        super([parentUserId, ownerId]) {
    this.parentId = parentUserId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$runtimeType{ parentUserId: $parentId, ownerId: $ownerId, cursor: $cursor }';
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
