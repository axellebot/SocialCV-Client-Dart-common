import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

class ProfileListBloc extends ElementListBloc<ProfileViewModel,
    ProfileListEvent, ProfileListState> {
  final String _tag = '$ProfileListBloc';

  ProfileListBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  ProfileListState get initialState => ProfileListUninitialized();

  @override
  Stream<ProfileListState> mapEventToState(ProfileListEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is ProfileListInitialized) {
      yield* _mapProfileListInitializedEventToState(event);
    } else if (event is ProfileListRefresh) {
      yield* _mapProfileListRefreshEventToState(event);
    } else if (event is ProfileListLoadMore) {
      yield* _mapProfileListLoadMoreEventToState(event);
    }
  }

  /// Map [ProfileListInitialized] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListInitializedEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListInitializedEventToState(
      ProfileListInitialized event) async* {
    print('$_tag:$_mapProfileListInitializedEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream

      parentId = event.parentId;
      ownerId = event.ownerId;
      cursor = event.cursor;

      elements = await _fetchProfiles(cursor: cursor);

      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
    }
  }

  /// Map [ProfileListRefresh] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListRefreshEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListRefreshEventToState(
      ProfileListRefresh event) async* {
    print('$_tag:$_mapProfileListRefreshEventToState($event)');
    try {
      /// TODO: Add refresh indicator stream
      elements = await _fetchProfiles(cursor: cursor);
      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
    }
  }

  /// Map [ProfileListLoadMore] to [ProfileListState]
  ///
  /// ```dart
  /// yield* _mapProfileListLoadMoreEventToState(event);
  /// ```
  Stream<ProfileListState> _mapProfileListLoadMoreEventToState(
      ProfileListLoadMore event) async* {
    print('$_tag:$_mapProfileListLoadMoreEventToState($event)');
    try {
      /// TODO: Add load more indicator stream

      List<ProfileViewModel> profiles = await _fetchProfiles(
        cursor: event.cursor.copyWith(offset: elements.length),
      );

      /// Append to elements
      elements.addAll(profiles);

      /// Save cursor limit if use list refreshed
      cursor = cursor.copyWith(limit: elements.length);

      yield ProfileListLoaded(profiles: elements);
    } catch (error) {
      yield ProfileListFailure(error: error);
    }
  }

  Future<List<ProfileViewModel>> _fetchProfiles(
      {@required Cursor cursor}) async {
    print('$_tag:$_fetchProfiles({cursor: $cursor})');
    if (parentId != null) {
      return await cvRepository.fetchProfilesFromUser(
        userId: parentId,
        cursor: cursor,
      );
    } else if (ownerId != null) {
      return await cvRepository.fetchProfilesFromUser(
        userId: ownerId,
        cursor: cursor,
      );
    } else {
      return await cvRepository.fetchProfiles(
        cursor: cursor,
      );
    }
  }
}
