import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

class ProfileBloc
    extends ElementBloc<ProfileViewModel, ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  @override
  get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is ProfileInitialized && event.elementId != null) {
        yield* _mapInitializedEventWithElementToState(event);
      } else if (event is ProfileInitialized && event.element != null) {
        yield* _mapInitializedEventWithIdToState(event);
      }
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  Stream<ProfileState> _mapInitializedEventWithElementToState(
      ProfileInitialized event) async* {
    try {
      yield ProfileLoading();

      elementId = event.elementId;
      elementViewModel = event.element;

      yield ProfileLoaded(profile: elementViewModel);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  Stream<ProfileState> _mapInitializedEventWithIdToState(
      ProfileInitialized event) async* {
    try {
      yield ProfileLoading();

      elementId = event.elementId;
      elementViewModel = await cvRepository.fetchProfile(elementId);

      yield ProfileLoaded(profile: elementViewModel);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }
}
