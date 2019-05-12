import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

class ProfileBloc
    extends ElementBloc<ProfileViewModel, ProfileEvent, ProfileState> {
  final String _tag = '$ProfileBloc';

  ProfileBloc({@required CVRepository cvRepository})
      : super(cvRepository: cvRepository);

  /// [_fallBackId] is used if [element] is never assigned and
  /// an [ProfileRefresh] is dispatched
  String _fallBackId;

  @override
  get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    print('$_tag:$mapEventToState($event)');
    if (event is ProfileInitialized) {
      yield* _mapInitializedEventToState(event);
    } else if (event is ProfileRefresh) {
      yield* _mapRefreshEventToState(event);
    }
  }

  Stream<ProfileState> _mapInitializedEventToState(
      ProfileInitialized event) async* {
    print('$_tag:$_mapInitializedEventToState($event)');
    try {
      yield ProfileLoading();

      if (event.elementId != null) {
        _fallBackId = event.elementId;
        element = await await cvRepository.fetchProfile(event.elementId);
      } else if (event.element != null) {
        _fallBackId = event.element.id;
        element = event.element;
      }

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }

  Stream<ProfileState> _mapRefreshEventToState(ProfileRefresh event) async* {
    print('$_tag:$_mapRefreshEventToState($event)');
    try {
      yield ProfileLoading();

      element = await cvRepository.fetchProfile(
        element?.id ?? _fallBackId,
        force: true,
      );

      _fallBackId = element.id;

      yield ProfileLoaded(profile: element);
    } catch (error) {
      yield ProfileFailure(error: error);
    }
  }
}
