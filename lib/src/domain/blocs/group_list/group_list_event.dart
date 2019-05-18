import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class GroupListEvent extends Equatable {
  GroupListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupListInitialized extends GroupListEvent
    with ElementListInitialized<GroupViewModel> {
  GroupListInitialized({
    String parentPartId,
    String ownerId,
    Cursor cursor,
  })  : assert(
          parentPartId != null && ownerId == null,
          '$GroupListInitialized must be created with a parentId or an ownerId',
        ),
        assert(
          parentPartId == null && ownerId != null,
          '$GroupListInitialized must be created with a parentId or an ownerId',
        ),
        super([parentPartId, ownerId]) {
    this.parentId = parentPartId;
    this.ownerId = ownerId;
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
