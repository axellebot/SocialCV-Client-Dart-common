import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/blocs/bloc_base.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/config_repository.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Business Logic Component for Authentication
class AuthBloc extends BlocBase {
  final String _TAG = "AuthBloc";

  AuthBloc({
    @required this.cvRepository,
    @required this.preferencesRepository,
    @required this.secretRepository,
  })  : assert(preferencesRepository != null),
        assert(cvRepository != null),
        assert(secretRepository != null),
        super() {
    _isAuthenticatingController.add(false);
    _isAuthenticatedController.add(false);
    _isFetchingAccountDetailsController.add(false);
  }

  CVRepository cvRepository;
  PreferencesRepository preferencesRepository;
  ConfigRepository secretRepository;

  // Reactive variables
  final _isAuthenticatingController = BehaviorSubject<bool>();
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isFetchingAccountDetailsController = BehaviorSubject<bool>();
  final _accountDetailsController = BehaviorSubject<UserDataModel>();

  // Streams
  Observable<bool> get isAuthenticatingStream =>
      _isAuthenticatingController.stream;

  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isFetchingAccountDetailsStream =>
      _isFetchingAccountDetailsController.stream;

  Observable<UserDataModel> get accountDetailsStream =>
      _accountDetailsController.stream;

  /// Functions
  Future<void> login(String username, String password) async {
    print('$_TAG:login');
    if (!_isAuthenticatingController.value) {
      _isAuthenticatingController.add(true);

      String clientId = await secretRepository.getClientId();
      String clientSecret = await secretRepository.getClientSecret();

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

      _isAuthenticatingController.add(false);
    }
  }

  Future<void> logout() async {
    print('$_TAG:logout');
    if (!_isAuthenticatingController.value) {
      _isAuthenticatingController.add(true);

      await preferencesRepository.deleteAccessToken();
      await preferencesRepository.deleteAccessTokenExpiration();
      await preferencesRepository.deleteRefreshToken();
      await preferencesRepository.deleteRefreshTokenExpiration();
      await preferencesRepository.deleteUserId();

      _accountDetailsController.add(null);
      _isAuthenticatedController.add(false);

      _isAuthenticatingController.add(false);
    }
  }

  Future<void> fetchAccountDetails() async {
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
    _isAuthenticatingController.close();
    _isAuthenticatedController.close();
    _isFetchingAccountDetailsController.close();
    _accountDetailsController.close();
  }
}
