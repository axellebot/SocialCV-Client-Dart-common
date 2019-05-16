import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class GroupListEvent extends Equatable {
  GroupListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType';
}

class GroupListInitialized extends GroupListEvent
    with ElementListInitialized<GroupViewModel> {
  GroupListInitialized({
    String withParentPartId,
    String withOwnerId,
    Cursor cursor,
  })  : assert(withParentPartId != null && withOwnerId == null),
        assert(withParentPartId == null && withOwnerId != null),
        super([withParentPartId, withOwnerId]) {
    this.parentId = withParentPartId;
    this.ownerId = withOwnerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$runtimeType{ parentPartId: $parentId, ownerId: $ownerId, cursor: $cursor }';
}

class GroupListRefresh extends GroupListEvent
    with ElementListRefresh<GroupViewModel> {}

class GroupListLoadMore extends GroupListEvent
    with ElementListLoadMore<GroupViewModel> {
  GroupListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$runtimeType{ cursor: $cursor }';
}
