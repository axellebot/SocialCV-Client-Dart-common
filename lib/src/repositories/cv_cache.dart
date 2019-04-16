import 'dart:async';

import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

const String _TAG = "CVCache";

/// Interface for CVCache (depends on the platform flutter/angular/...)
abstract class CVCache {
  ///
  /// Account
  ///

  Future<UserDataModel> getAccount();

  void setAccount(UserDataModel userModel);

  ///
  /// Users
  ///

  Future<UserDataModel> getUser(String userId);

  void setUser(UserDataModel userModel);

  ///
  /// Profiles
  ///

  Future<ProfileDataModel> getProfile(String profileId);

  void setProfile(ProfileDataModel profileModel);

  ///
  /// Parts
  ///

  Future<PartDataModel> getPart(String partId);

  void setPart(PartDataModel partModel);

  ///
  /// Groups
  ///

  Future<GroupDataModel> getGroup(String groupId);

  void setGroup(GroupDataModel groupModel);

  ///
  /// Entries
  ///

  Future<EntryDataModel> getEntry(String entryId);

  void setEntry(EntryDataModel entryModel);
}

///
/// Default implementation of [CVCache]
///
class CVCacheImpl implements CVCache {
  CVCacheImpl();

  final _users = <String, _CacheModel<UserDataModel>>{};
  final _profiles = <String, _CacheModel<ProfileDataModel>>{};
  final _parts = <String, _CacheModel<PartDataModel>>{};
  final _groups = <String, _CacheModel<GroupDataModel>>{};
  final _entries = <String, _CacheModel<EntryDataModel>>{};

  _CacheModel<UserDataModel> accountCache;

  ///
  /// Account
  ///

  Future<UserDataModel> getAccount() async {
    return (accountCache != null && !accountCache.isExpired())
        ? accountCache.model
        : null;
  }

  void setAccount(UserDataModel userModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    this.accountCache =
        _CacheModel<UserDataModel>(model: userModel, expiration: expiration);
  }

  ///
  /// Users
  ///

  Future<UserDataModel> getUser(String userId) async {
    _CacheModel<UserDataModel> cacheModel = _users[userId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setUser(UserDataModel userModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
    _CacheModel<UserDataModel>(model: userModel, expiration: expiration);
    _users[userModel.id] = cacheModel;
  }

  ///
  /// Profiles
  ///

  Future<ProfileDataModel> getProfile(String profileId) async {
    _CacheModel<ProfileDataModel> cacheModel = _profiles[profileId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setProfile(ProfileDataModel profileModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
    _CacheModel<ProfileDataModel>(model: profileModel, expiration: expiration);
    _profiles[profileModel.id] = cacheModel;
  }

  ///
  /// Parts
  ///

  Future<PartDataModel> getPart(String partId) async {
    _CacheModel<PartDataModel> cacheModel = _parts[partId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setPart(PartDataModel partModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
    _CacheModel<PartDataModel>(model: partModel, expiration: expiration);
    _parts[partModel.id] = cacheModel;
  }

  ///
  /// Groups
  ///

  Future<GroupDataModel> getGroup(String groupId) async {
    _CacheModel<GroupDataModel> cacheModel = _groups[groupId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setGroup(GroupDataModel groupModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
    _CacheModel<GroupDataModel>(model: groupModel, expiration: expiration);
    _groups[groupModel.id] = cacheModel;
  }

  ///
  /// Entries
  ///

  Future<EntryDataModel> getEntry(String entryId) async {
    _CacheModel<EntryDataModel> cacheModel = _entries[entryId];
    return (cacheModel != null && !cacheModel.isExpired())
        ? cacheModel.model
        : null;
  }

  void setEntry(EntryDataModel entryModel) async {
    DateTime expiration = _generateExpirationDateTime(Duration(minutes: 1));
    final cacheModel =
    _CacheModel<EntryDataModel>(model: entryModel, expiration: expiration);
    _entries[entryModel.id] = cacheModel;
  }

  DateTime _generateExpirationDateTime(Duration duration) {
    DateTime.now().add(duration);
  }
}

class _CacheModel<T> {
  _CacheModel({
    this.model,
    this.expiration,
  })
      : assert(model != null),
        assert(model != null);

  T model;
  DateTime expiration;

  bool isExpired() {
    return DateTime.now().compareTo(expiration) >= 0 ? true : false;
  }
}
