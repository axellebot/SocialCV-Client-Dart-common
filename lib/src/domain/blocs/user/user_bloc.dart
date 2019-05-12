import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class UserBloc extends ElementBloc<UserViewModel, UserEvent, UserState> {
  final String _tag = '$UserBloc';

  UserBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is UserInitialized && event.elementId != null) {
        yield* _mapInitializedEventWithElementToState(event);
      } else if (event is UserInitialized && event.element != null) {
        yield* _mapInitializedEventWithIdToState(event);
      }
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  Stream<UserState> _mapInitializedEventWithElementToState(
      UserInitialized event) async* {
    try {
      yield UserLoading();

      elementId = event.elementId;
      elementViewModel = event.element;

      yield UserLoaded(user: elementViewModel);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }

  Stream<UserState> _mapInitializedEventWithIdToState(
      UserInitialized event) async* {
    try {
      yield UserLoading();

      elementId = event.elementId;
      elementViewModel = await cvRepository.fetchUser(elementId);

      yield UserLoaded(user: elementViewModel);
    } catch (error) {
      yield UserFailure(error: error);
    }
  }
}
