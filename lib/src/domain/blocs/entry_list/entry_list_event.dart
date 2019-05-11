import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class EntryListEvent extends Equatable {
  EntryListEvent([List props = const []]) : super(props);
}

class EntryListInitialized extends EntryListEvent
    with ElementListInitialized<EntryViewModel> {
  EntryListInitialized({
    String withParentId,
    List<EntryViewModel> withEntries,
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
      '$EntryListInitialized { parentId: $parentId, entries: $elements ownerId: $ownerId, cursor: $cursor }';
}

class EntryListRefresh extends EntryListEvent
    with ElementListRefresh<EntryViewModel> {
  @override
  String toString() => '$EntryListRefresh {}';
}

class EntryListLoadMore extends EntryListEvent
    with ElementListLoadMore<EntryViewModel> {
  EntryListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$EntryListLoadMore { cursor: $cursor }';
}
