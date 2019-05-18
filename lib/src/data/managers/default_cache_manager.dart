import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/models.dart';

///
/// Default implementation of [CVCacheManager]
///
class DefaultCVCacheManager implements CVCacheManager {
  final String _tag = '$DefaultCVCacheManager';

  DefaultCVCacheManager();

  final _users = <String, _CacheModel<UserDataModel>>{};
  final _profiles = <String, _CacheModel<ProfileDataModel>>{};
  final _parts = <String, _CacheModel<PartDataModel>>{};
  final _groups = <String, _CacheModel<GroupDataModel>>{};
  final _entries = <String, _CacheModel<EntryDataModel>>{};

  _CacheModel<UserDataModel> accountCache;

  /// ----------------------------------------------------------
  /// ------------------------ Account -------------------------
  /// ----------------------------------------------------------

  Future<UserDataModel> getAccount() async {
    print('$_tag:$getAccount');

    return (accountCache != null && !accountCache.isExpired())
        ? accountCache.model
        : null;
  }

  void setAccount(UserDataModel userModel) async {
    print('$_tag:$setAccount($userModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    this.accountCache =
        _CacheModel<UserDataModel>(model: userModel, expiration: expiration);
  }

  /// ----------------------------------------------------------
  /// ------------------------- Users --------------------------
  /// ----------------------------------------------------------

  Future<UserDataModel> getUser(String userId) async {
    print('$_tag:$getUser($userId)');

    _CacheModel<UserDataModel> cacheModel = _users[userId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setUser(UserDataModel userModel) async {
    print('$_tag:$setUser($userModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<UserDataModel>(model: userModel, expiration: expiration);
    _users[userModel.id] = cacheModel;
  }

  /// ----------------------------------------------------------
  /// ----------------------- Profiles -------------------------
  /// ----------------------------------------------------------

  Future<ProfileDataModel> getProfile(String profileId) async {
    print('$_tag:$getProfile($profileId)');

    _CacheModel<ProfileDataModel> cacheModel = _profiles[profileId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setProfile(ProfileDataModel profileModel) async {
    print('$_tag:$setProfile($profileModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel = _CacheModel<ProfileDataModel>(
        model: profileModel, expiration: expiration);
    _profiles[profileModel.id] = cacheModel;
  }

  /// ----------------------------------------------------------
  /// ------------------------- Parts --------------------------
  /// ----------------------------------------------------------

  Future<PartDataModel> getPart(String partId) async {
    print('$_tag:$getPart($partId)');

    _CacheModel<PartDataModel> cacheModel = _parts[partId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setPart(PartDataModel partModel) async {
    print('$_tag:$setPart($partModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<PartDataModel>(model: partModel, expiration: expiration);
    _parts[partModel.id] = cacheModel;
  }

  /// ----------------------------------------------------------
  /// ------------------------ Groups --------------------------
  /// ----------------------------------------------------------

  Future<GroupDataModel> getGroup(String groupId) async {
    print('$_tag:$getGroup($groupId)');

    _CacheModel<GroupDataModel> cacheModel = _groups[groupId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setGroup(GroupDataModel groupModel) async {
    print('$_tag:$setGroup($groupModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<GroupDataModel>(model: groupModel, expiration: expiration);
    _groups[groupModel.id] = cacheModel;
  }

  /// ----------------------------------------------------------
  /// ----------------------- Entries --------------------------
  /// ----------------------------------------------------------

  Future<EntryDataModel> getEntry(String entryId) async {
    print('$_tag:$getEntry($entryId)');

    _CacheModel<EntryDataModel> cacheModel = _entries[entryId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setEntry(EntryDataModel entryModel) async {
    print('$_tag:$setEntry($entryModel)');

    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
        _CacheModel<EntryDataModel>(model: entryModel, expiration: expiration);
    _entries[entryModel.id] = cacheModel;
  }

  DateTime _generateExpirationDateTime(Duration duration) {
    return DateTime.now().add(duration);
  }
}

class _CacheModel<T> {
  _CacheModel({
    @required this.model,
    @required this.expiration,
  })  : assert(model != null),
        assert(model != null);

  T model;
  DateTime expiration;

  bool isExpired() {
    return DateTime.now().compareTo(expiration) >= 0 ? true : false;
  }
}
