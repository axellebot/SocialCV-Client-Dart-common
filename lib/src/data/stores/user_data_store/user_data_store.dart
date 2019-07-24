import 'dart:async';

import 'package:social_cv_client_dart_common/data.dart';
import 'package:social_cv_client_dart_common/presentation.dart';

abstract class UserDataStore {
  FutureOr<UserDataModel> getUser(String userId);

  FutureOr<UserDataModel> setUser(UserDataModel userModel);

  FutureOr<List<UserDataModel>> getUsers({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
