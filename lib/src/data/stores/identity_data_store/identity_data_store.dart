import 'dart:async';

import 'package:social_cv_client_dart_common/data.dart';

abstract class IdentityDataStore {
  FutureOr<UserDataModel> getIdentity();

  FutureOr<UserDataModel> setIdentity(UserDataModel userModel);
}
