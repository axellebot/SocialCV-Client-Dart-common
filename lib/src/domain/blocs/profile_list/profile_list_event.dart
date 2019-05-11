import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class ProfileListEvent extends Equatable {
  ProfileListEvent([List props = const []]) : super(props);
}

class ProfileListInitialized extends ProfileListEvent
    with ElementListInitialized<ProfileViewModel> {
  ProfileListInitialized({
    String withParentId,
    List<ProfileViewModel> withEntries,
    String withOwnerId,
    Cursor cursor,
  })  : assert(
            withParentId != null || withEntries != null || withOwnerId != null),
        super([withParentId, withEntries, withOwnerId]) {
    this.parentId = withParentId;
    this.elements = withEntries;
    this.ownerId = withOwnerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$ProfileListInitialized { parentId: $parentId, entries: $elements ownerId: $ownerId, cursor: $cursor }';
}

class ProfileListRefresh extends ProfileListEvent
    with ElementListRefresh<ProfileViewModel> {
  @override
  String toString() => '$ProfileListRefresh {}';
}

class ProfileListLoadMore extends ProfileListEvent
    with ElementListLoadMore<ProfileViewModel> {
  ProfileListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$ProfileListLoadMore { cursor: $cursor }';
}
