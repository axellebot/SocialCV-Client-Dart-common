import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

/// Business Logic Component for Group list
class GroupListBloc
    extends ElementListBloc<GroupViewModel, GroupListEvent, GroupListState> {
  final String _tag = '$GroupListBloc';

  GroupListBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  GroupListState get initialState => GroupListUninitialized();

  @override
  Stream<GroupListState> mapEventToState(GroupListEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is GroupListInitialized) {
      yield* _mapGroupListInitializedEventToState(event);
    } else if (event is GroupListRefresh) {
      yield* _mapGroupListRefreshEventToState(event);
    } else if (event is GroupListLoadMore) {
      yield* _mapGroupListLoadMoreEventToState(event);
    }
  }

  /// Map [GroupListInitialized] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListInitializedEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListInitializedEventToState(
      GroupListInitialized event) async* {
    print('$_tag:$_mapGroupListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _fetchGroups(cursor: cursor);

      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  /// Map [GroupListRefresh] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListRefreshEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListRefreshEventToState(
      GroupListRefresh event) async* {
    print('$_tag:$_mapGroupListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _fetchGroups(cursor: cursor);
      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  /// Map [GroupListLoadMore] to [GroupListState]
  ///
  /// ```dart
  /// yield* _mapGroupListLoadMoreEventToState(event);
  /// ```
  Stream<GroupListState> _mapGroupListLoadMoreEventToState(
      GroupListLoadMore event) async* {
    print('$_tag:$_mapGroupListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      List<GroupViewModel> groups = await _fetchGroups(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(groups);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield GroupListLoaded(groups: elements);
    } catch (error) {
      yield GroupListFailure(error: error);
    }
  }

  Future<List<GroupViewModel>> _fetchGroups({@required Cursor cursor}) async {
    print('$_tag:$_fetchGroups({cursor: $cursor})');
    if (parentId != null) {
      return await cvRepository.fetchGroupsFromPart(
        partId: parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await cvRepository.fetchGroupsFromUser(
        userId: ownerId,
        cursor: cursor,
      );
    } else {
      return await cvRepository.fetchGroups(
        cursor: cursor,
      );
    }
  }
}
