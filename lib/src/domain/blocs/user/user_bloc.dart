import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Business Logic Component for User
class UserBloc extends ElementBloc<UserViewModel, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [UserRefresh] is dispatched
  String _fallBackId;

  @override
  get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is UserInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is UserRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  /// Map [UserInitialized] to [UserState]
  ///
  /// ```dart
  /// yield* _mapInitializedEventToState(event);
  /// ```
  Stream<UserState> _mapInitializedEventToState(UserInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield UserLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await cvRepository.fetchUser(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  /// Map [UserRefresh] to [UserState]
  ///
  /// ```dart
  /// yield* _mapRefreshEventToState(event);
  /// ```
  Stream<UserState> _mapRefreshEventToState(UserRefresh event) async* {
    print('$_tag:$_mapRefreshEventToState($event)');
    try {
      yield UserLoading();

      element = await cvRepository.fetchUser(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }
}
