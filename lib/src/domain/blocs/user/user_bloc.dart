import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class UserBloc
    extends ElementBloc<UserViewModel, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is UserInitialized) {
        yield* _mapInitializedEventToState(event);
      } else if (event is UserRefresh) {
        yield* _mapRefreshEventToState(event);
      }
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  Stream<UserState> _mapInitializedEventToState(
      UserInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield UserLoading();

      if (event.elementId != null) {
        element = await _fetchUser(event.elementId);
      } else if (event.element != null) {
        element = event.element;
      }

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  Stream<UserState> _mapRefreshEventToState(UserRefresh event) async* {
    try {
      yield UserLoading();

      element = await _fetchUser(element?.id);

      yield UserLoaded(user: element);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [UserRefresh] is dispatched
  String _fallBackId;

  Future<UserViewModel> _fetchUser(String userId) async {
    if (userId == null) userId = _fallBackId;
    _fallBackId = userId;
    return await cvRepository.fetchUser(userId);
  }
}
