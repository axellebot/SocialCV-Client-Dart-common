import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

class PartListBloc
    extends ElementListBloc<PartViewModel, PartListEvent, PartListState> {
  final String _tag = '$PartListBloc';

  PartListBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  PartListState get initialState => PartListUninitialized();

  @override
  Stream<PartListState> mapEventToState(PartListEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is PartListInitialized) {
      yield* _mapPartListInitializedEventToState(event);
    } else if (event is PartListRefresh) {
      yield* _mapPartListRefreshEventToState(event);
    } else if (event is PartListLoadMore) {
      yield* _mapPartListLoadMoreEventToState(event);
    }
  }

  Stream<PartListState> _mapPartListInitializedEventToState(
      PartListInitialized event) async* {
    print('$_tag:$_mapPartListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      if (elements != null && event.elements.isNotEmpty) {
        elements = event.elements;
      } else {
        elements = await _fetchParts(cursor: cursor);
      }

      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  Stream<PartListState> _mapPartListRefreshEventToState(
      PartListRefresh event) async* {
    print('$_tag:$_mapPartListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _fetchParts(cursor: cursor);
      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  Stream<PartListState> _mapPartListLoadMoreEventToState(
      PartListLoadMore event) async* {
    print('$_tag:$_mapPartListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      List<PartViewModel> parts = await _fetchParts(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(parts);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield PartListLoaded(parts: elements);
    } catch (error) {
      yield PartListFailure(error: error);
    }
  }

  Future<List<PartViewModel>> _fetchParts({@required Cursor cursor}) async {
    print('$_tag:$_fetchParts({cursor: $cursor})');
    if (parentId != null) {
      return await cvRepository.fetchPartsFromProfile(
        profileId: parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await cvRepository.fetchPartsFromUser(
        userId: ownerId,
        cursor: cursor,
      );
    } else {
      return await cvRepository.fetchParts(
        cursor: cursor,
      );
    }
  }
}
