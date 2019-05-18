import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class EntryListEvent extends Equatable {
  EntryListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryListInitialized extends EntryListEvent
    with ElementListInitialized<EntryViewModel> {
  EntryListInitialized({
    String parentGroupId,
    String ownerId,
    Cursor cursor,
  })  : assert(
          parentGroupId != null && ownerId == null,
          '$EntryListInitialized must be created with a parentId or an ownerId',
        ),
        assert(
          parentGroupId == null && ownerId != null,
          '$EntryListInitialized must be created with a parentId or an ownerId',
        ),
        super([parentGroupId, ownerId]) {
    this.parentId = parentGroupId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$runtimeType{ parentId: $parentId, ownerId: $ownerId, cursor: $cursor }';
}

class EntryListRefresh extends EntryListEvent
    with ElementListRefresh<EntryViewModel> {}

class EntryListLoadMore extends EntryListEvent
    with ElementListLoadMore<EntryViewModel> {
  EntryListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$runtimeType{ cursor: $cursor }';
}
