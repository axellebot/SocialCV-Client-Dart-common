import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class GroupListEvent extends Equatable {
  GroupListEvent([List props = const []]) : super(props);
}

class GroupListInitialized extends GroupListEvent
    with ElementListInitialized<GroupViewModel> {
  GroupListInitialized({
    String withParentId,
    List<GroupViewModel> withEntries,
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
      '$GroupListInitialized { parentId: $parentId, entries: $elements ownerId: $ownerId, cursor: $cursor }';
}

class GroupListRefresh extends GroupListEvent
    with ElementListRefresh<GroupViewModel> {
  @override
  String toString() => '$GroupListRefresh {}';
}

class GroupListLoadMore extends GroupListEvent
    with ElementListLoadMore<GroupViewModel> {
  GroupListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$GroupListLoadMore { cursor: $cursor }';
}
