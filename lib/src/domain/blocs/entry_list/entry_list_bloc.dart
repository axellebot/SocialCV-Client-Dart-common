import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

/// Business Logic Component for Entry list
class EntryListBloc
    extends ElementListBloc<EntryViewModel, EntryListEvent, EntryListState> {
  final String _tag = '$EntryListBloc';

  EntryListBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  EntryListState get initialState => EntryListUninitialized();

  @override
  Stream<EntryListState> mapEventToState(EntryListEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is EntryListInitialized) {
      yield* _mapEntryListInitializedEventToState(event);
    } else if (event is EntryListRefresh) {
      yield* _mapEntryListRefreshEventToState(event);
    } else if (event is EntryListLoadMore) {
      yield* _mapEntryListLoadMoreEventToState(event);
    }
  }

  /// Map [EntryListInitialized] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListInitializedEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListInitializedEventToState(
      EntryListInitialized event) async* {
    print('$_tag:$_mapEntryListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _fetchEntries(cursor: event.cursor);

      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  /// Map [EntryListRefresh] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListRefreshEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListRefreshEventToState(
      EntryListRefresh event) async* {
    print('$_tag:$_mapEntryListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _fetchEntries(cursor: cursor);
      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  /// Map [EntryListLoadMore] to [EntryListState]
  ///
  /// ```dart
  /// yield* _mapEntryListRefreshEventToState(event);
  /// ```
  Stream<EntryListState> _mapEntryListLoadMoreEventToState(
      EntryListLoadMore event) async* {
    print('$_tag:$_mapEntryListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      List<EntryViewModel> entries = await _fetchEntries(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(entries);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield EntryListLoaded(entries: elements);
    } catch (error) {
      yield EntryListFailure(error: error);
    }
  }

  Future<List<EntryViewModel>> _fetchEntries({@required Cursor cursor}) async {
    print('$_tag:$_fetchEntries({cursor: $cursor})');
    if (parentId != null) {
      return await cvRepository.fetchEntriesFromGroup(
        groupId: parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await cvRepository.fetchEntriesFromUser(
        userId: ownerId,
        cursor: cursor,
      );
    } else {
      return await cvRepository.fetchEntries(
        cursor: cursor,
      );
    }
  }
}
