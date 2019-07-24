import 'dart:async';

import 'package:social_cv_client_dart_common/data.dart';
import 'package:social_cv_client_dart_common/presentation.dart';

/// Memory implementation of [UserDataStore]
class MemoryUserDataStore implements UserDataStore {
  final String _tag = '$MemoryUserDataStore';

  MemoryUserDataStore();

  final _users = <String, CacheModel<UserDataModel>>{};

  @override
  FutureOr<UserDataModel> getUser(String userId) async {
    print('$_tag:getUser($userId)');

    final CacheModel<UserDataModel> cacheModel = _users[userId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  @override
  FutureOr<UserDataModel> setUser(UserDataModel userModel) async {
    print('$_tag:setUser($userModel)');

    final DateTime expiration =
        generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        CacheModel<UserDataModel>(model: userModel, expiration: expiration);
    _users[userModel.id] = cacheModel;

    return cacheModel.model;
  }

  @override
  FutureOr<List<UserDataModel>> getUsers({
    Cursor cursor = const Cursor(),
  }) {
    print('$_tag:getUsers');
    return _users.values.map((value) => value.model).toList();
  }

  @override
  String toString() => '$runtimeType{}';
}
