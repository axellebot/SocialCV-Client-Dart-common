import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/errors/app_error.dart';
import 'package:social_cv_client_dart_common/src/managers/cache_manager.dart';
import 'package:social_cv_client_dart_common/src/managers/cv_api_manager.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_repository.dart';

/// Default Implementation of [CVRepository]
class DefaultCloudCVRepository extends CVRepository {
  final String _TAG = 'DefaultCloudCVRepository';

  DefaultCloudCVRepository({
    @required this.apiManager,
    @required this.cacheManager,
  });

  final CVApiManager apiManager;
  final CVCacheManager cacheManager;

  ///
  /// OAuth
  ///

  @override
  Future<OAuthAccessTokenResponseModel> authenticate({
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:authenticate');
    return await apiManager.fetchToken(email: email, password: password);
  }

  Future<OAuthAccessTokenResponseModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:register');
    throw NotImplementedYetError();
  }

  ///
  /// Account
  ///

  @override
  Future<UserDataModel> fetchAccount() async {
    print('$_TAG:fetchAccount');

    var model = await cacheManager.getAccount();

    if (model == null) {
      var response = await apiManager.fetchAccount();
      var model = response.data;
      cacheManager.setAccount(model);
    }

    return model;
  }

  @override
  Future<List<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromAccount');

    var response = await apiManager.fetchProfilesFromAccount(
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  ///
  /// Profiles
  ///

  @override
  Future<ProfileDataModel> fetchProfile(String profileId) async {
    print('$_TAG:fetchProfile($profileId)');

    var model = await cacheManager.getProfile(profileId);

    if (model == null) {
      var response = await apiManager.fetchProfile(profileId);
      model = response.data;
      cacheManager.setProfile(model);
    }

    return model;
  }

  @override
  Future<List<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfiles');

    var response = await apiManager.fetchProfiles(
      profileTitle: profileTitle,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromUser($userId)');

    var response = await apiManager.fetchProfilesFromUser(
      userId: userId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  ///
  /// Parts
  ///

  @override
  Future<PartDataModel> fetchPart(String partId) async {
    print('$_TAG:fetchPart($partId)');

    var model = await cacheManager.getPart(partId);

    if (model == null) {
      var response = await apiManager.fetchPart(partId);
      model = response.data;
      cacheManager.setPart(model);
    }

    return model;
  }

  @override
  Future<List<PartDataModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchParts');

    var response = await apiManager.fetchParts(offset: offset, limit: limit);

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<PartDataModel>> fetchPartsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchPartsFromUser($userId)');

    var response = await apiManager.fetchPartsFromUser(
      userId: userId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchPartsFromProfile');

    var response = await apiManager.fetchPartsFromProfile(
      profileId: profileId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  ///
  /// Groups
  ///

  @override
  Future<GroupDataModel> fetchGroup(String groupId) async {
    print('$_TAG:fetchGroup($groupId)');

    var model = await cacheManager.getGroup(groupId);
    if (model == null) {
      var response = await apiManager.fetchGroup(groupId);
      model = response.data;
      cacheManager.setGroup(model);
    }
    return model;
  }

  @override
  Future<List<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroups');

    var response = await apiManager.fetchGroups(offset: offset, limit: limit);

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<GroupDataModel>> fetchGroupsFromUser({
    String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroupsFromUser($userId)');

    var response = await apiManager.fetchGroupsFromUser(
      userId: userId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<GroupDataModel>> fetchGroupsFromPart({
    String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroupsFromPart($partId)');

    var response = await apiManager.fetchGroupsFromPart(
      partId: partId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  ///
  /// Entries
  ///

  @override
  Future<EntryDataModel> fetchEntry(String entryId) async {
    print('$_TAG:fetchEntry($entryId)');

    var model = await cacheManager.getEntry(entryId);
    if (model == null) {
      var response = await apiManager.fetchEntry(entryId);
      model = response.data;
      cacheManager.setEntry(model);
    }
    return model;
  }

  @override
  Future<List<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntries');
    var response = await apiManager.fetchEntries(offset: offset, limit: limit);

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<EntryDataModel>> fetchEntriesFromUser({
    String userId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntriesFromUser($userId)');

    var response = await apiManager.fetchEntriesFromUser(
      userId: userId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  @override
  Future<List<EntryDataModel>> fetchEntriesFromGroup({
    String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntriesFromGroup($groupId)');

    var response = await apiManager.fetchEntriesFromGroup(
      groupId: groupId,
      offset: offset,
      limit: limit,
    );

    var models = response.data;

    _setCaches(models);

    return models;
  }

  ///
  /// Tools
  ///

  void _setCaches(List models) {
    for (var model in models) {
      if (model is UserDataModel) {
        cacheManager.setUser(model);
      } else if (model is ProfileDataModel) {
        cacheManager.setProfile(model);
      } else if (model is PartDataModel) {
        cacheManager.setPart(model);
      } else if (model is GroupDataModel) {
        cacheManager.setGroup(model);
      } else if (model is EntryDataModel) {
        cacheManager.setEntry(model);
      }
    }
  }
}
