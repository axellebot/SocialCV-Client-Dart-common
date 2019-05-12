import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ProfileBloc
    extends ElementBloc<ProfileViewModel, ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  ProfileBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  @override
  get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    try {
      if (event is ProfileInitialized) {
        yield* _mapInitializedEventToState(event);
      } else if (event is ProfileRefresh) {
        yield* _mapRefreshEventToState(event);
      }
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  Stream<ProfileState> _mapInitializedEventToState(
      ProfileInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield ProfileLoading();

      if (event.elementId != null) {
        element = await _fetchProfile(event.elementId);
      } else if (event.element != null) {
        element = event.element;
      }

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  Stream<ProfileState> _mapRefreshEventToState(ProfileRefresh event) async* {
    try {
      yield ProfileLoading();

      element = await _fetchProfile(element?.id);

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [ProfileRefresh] is dispatched
  String _fallBackId;

  Future<ProfileViewModel> _fetchProfile(String profileId) async {
    if (profileId == null) profileId = _fallBackId;
    _fallBackId = profileId;
    return await cvRepository.fetchProfile(profileId);
  }
}
