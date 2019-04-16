import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/secrets_repository.dart';

const String _TAG = "AccountBloc";

class AccountBloc extends BlocBase {
  AccountBloc({
    this.cvRepository,
    this.preferencesRepository,
    this.secretRepository,
  })  : assert(preferencesRepository != null),
        assert(cvRepository != null),
        assert(secretRepository != null),
        super() {
    _isAuthenticatedController.add(false);
    _isLoggingController.add(false);
    _isFetchingAccountDetailsController.add(false);
  }

  CVRepositoryImpl cvRepository;
  PreferencesRepository preferencesRepository;
  SecretsRepository secretRepository;

  // Reactive variables
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isLoggingController = BehaviorSubject<bool>();
  final _isFetchingAccountDetailsController = BehaviorSubject<bool>();
  final _accountDetailsController = BehaviorSubject<UserDataModel>();

  // Streams
  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isLoggingStream => _isLoggingController.stream;

  Observable<bool> get isFetchingAccountDetailsStream =>
      _isFetchingAccountDetailsController.stream;

  Observable<UserDataModel> get accountDetailsStream =>
      _accountDetailsController.stream;

  /* Functions */
  void login(String username, String password) async {
    print('$_TAG:login');
    if (!_isLoggingController.value) {
      _isLoggingController.add(true);

      String clientId = await secretRepository.loadclientId();
      String clientSecret = await secretRepository.loadclientSecret();

      OAuthTokenModel oauthModel = OAuthTokenModel(
        username: username,
        password: password,
        clientId: clientId,
        clientSecret: clientSecret,
        grantType: "password",
      );
      await cvRepository
          .fetchToken(
        oauthTokenModel: oauthModel,
      )
          .then((OAuthAccessTokenResponseModel response) async {
        /// TODO : Add Expiration
        await preferencesRepository.setAccessToken(response.accessToken);
//        await preferencesRepository.setAccessTokenExpiration(response.accessTokenExpiresAt);
        await preferencesRepository.setRefreshToken(response.refreshToken);
//        await preferencesRepository.setRefreshTokenExpiration(response.);

        await _isAuthenticatedController.add(true);
        await this.fetchAccountDetails();
      }).catchError(_accountDetailsController.addError);

      _isLoggingController.add(false);
    }
  }

  void logout() async {
    print('$_TAG:logout');
    if (!_isLoggingController.value) {
      _isLoggingController.add(true);

      await preferencesRepository.deleteAccessToken();
      await preferencesRepository.deleteAccessTokenExpiration();
      await preferencesRepository.deleteRefreshToken();
      await preferencesRepository.deleteRefreshTokenExpiration();
      await preferencesRepository.deleteUserId();

      _accountDetailsController.add(null);
      _isAuthenticatedController.add(false);

      _isLoggingController.add(false);
    }
  }

  void fetchAccountDetails() async {
    print('$_TAG:fetchAccountDetails');
    if (!_isFetchingAccountDetailsController.value) {
      _isFetchingAccountDetailsController.add(true);

      await cvRepository.fetchAccount().then((UserDataModel userModel) {
        preferencesRepository.setUserId(userModel.id);
        _accountDetailsController.add(userModel);
      }).catchError(_accountDetailsController.addError);

      _isFetchingAccountDetailsController.add(false);
    }
  }

  @override
  void dispose() {
    _isAuthenticatedController.close();
    _isLoggingController.close();
    _isFetchingAccountDetailsController.close();
    _accountDetailsController.close();
  }
}
