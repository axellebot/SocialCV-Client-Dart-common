import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class PartListEvent extends Equatable {
  PartListEvent([List props = const []]) : super(props);
}

class PartListInitialized extends PartListEvent
    with ElementListInitialized<PartViewModel> {
  PartListInitialized({
    String withParentId,
    List<PartViewModel> withEntries,
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
      '$PartListInitialized { parentId: $parentId, entries: $elements ownerId: $ownerId, cursor: $cursor }';
}

class PartListRefresh extends PartListEvent
    with ElementListRefresh<PartViewModel> {
  @override
  String toString() => '$PartListRefresh {}';
}

class PartListLoadMore extends PartListEvent
    with ElementListLoadMore<PartViewModel> {
  PartListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$PartListLoadMore { cursor: $cursor }';
}
