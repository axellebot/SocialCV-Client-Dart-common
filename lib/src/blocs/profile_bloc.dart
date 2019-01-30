import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/profile_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

const String _TAG = "ProfileBloc";

/// Business Logic Component for Profile Fetch
class ProfileBloc extends BlocBase {
  ProfileBloc({
    this.cvRepository,
  })
      : assert(cvRepository != null),
        super() {
    _isFetchingProfileController.add(false);
  }

  final CVRepositoryImpl cvRepository;

  // Reactive variables
  final _isFetchingProfileController = BehaviorSubject<bool>();
  final _profileController = BehaviorSubject<ProfileModel>();

  // Streams
  Observable<bool> get isFetchingProfileStream =>
      _isFetchingProfileController.stream;

  Observable<ProfileModel> get profileStream => _profileController.stream;

  void fetchProfileDetails(String profileId) async {
    print('$_TAG:fetchProfileDetails');
    if (!_isFetchingProfileController.value) {
      _isFetchingProfileController.add(true);

      await cvRepository
          .fetchProfile(profileId)
          .then(_profileController.add)
          .catchError(_profileController.addError);

      _isFetchingProfileController.add(false);
    }
  }

  @override
  void dispose() {
    _isFetchingProfileController.close();
    _profileController.close();
  }
}
