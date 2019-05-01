import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// Default Implementation of [CVRepository]
class DefaultCloudCVRepository extends CVRepository {
  final String _TAG = 'DefaultCloudCVRepository';

  final CVApiManager apiManager;
  final CVCacheManager cacheManager;

  DefaultCloudCVRepository({
    @required this.apiManager,
    @required this.cacheManager,
  })  : assert(apiManager != null, 'Missing API Manager'),
        assert(cacheManager != null, 'Missing Cache Manager');

  ///
  /// OAuth
  ///

  @override
  Future<AccessTokenViewModelModel> authenticate({
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:authenticate');
    var reponse = await apiManager.fetchToken(email: email, password: password);
    return ModelMapper.instance.fromOAuthAccessToken(reponse);
  }

  Future<AccessTokenViewModelModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  }) async {
    print('$_TAG:register');
    throw NotImplementedYetError();
//    return ModelMapper.instance.fromOAuthAccessToken(reponse);
  }

  ///
  /// Account
  ///

  @override
  Future<UserViewModel> fetchAccount() async {
    print('$_TAG:fetchAccount');

    var dataModel = await cacheManager.getAccount();

    if (dataModel == null) {
      var response = await apiManager.fetchAccount();
      var model = response.data;
      cacheManager.setAccount(model);
    }

    return ModelMapper.instance.fromUserDataModel(dataModel);
  }

  @override
  Future<List<ProfileViewModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchProfilesFromAccount');

    var response = await apiManager.fetchProfilesFromAccount(
      offset: offset,
      limit: limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels.map(
        (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel));
  }

  ///
  /// Profiles
  ///

  @override
  Future<ProfileViewModel> fetchProfile(String profileId) async {
    print('$_TAG:fetchProfile($profileId)');

    var dataModel = await cacheManager.getProfile(profileId);

    if (dataModel == null) {
      var response = await apiManager.fetchProfile(profileId);
      dataModel = response.data;
      cacheManager.setProfile(dataModel);
    }

    return ModelMapper.instance.fromProfileDataModel(dataModel);
  }

  @override
  Future<List<ProfileViewModel>> fetchProfiles({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels.map(
        (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel));
  }

  @override
  Future<List<ProfileViewModel>> fetchProfilesFromUser({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels.map(
        (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel));
  }

  ///
  /// Parts
  ///

  @override
  Future<PartViewModel> fetchPart(String partId) async {
    print('$_TAG:fetchPart($partId)');

    var dataModel = await cacheManager.getPart(partId);

    if (dataModel == null) {
      var response = await apiManager.fetchPart(partId);
      dataModel = response.data;
      cacheManager.setPart(dataModel);
    }

    return ModelMapper.instance.fromPartDataModel(dataModel);
  }

  @override
  Future<List<PartViewModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchParts');

    var response = await apiManager.fetchParts(offset: offset, limit: limit);

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel));
  }

  @override
  Future<List<PartViewModel>> fetchPartsFromUser({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel));
  }

  @override
  Future<List<PartViewModel>> fetchPartsFromProfile({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel));
  }

  ///
  /// Groups
  ///

  @override
  Future<GroupViewModel> fetchGroup(String groupId) async {
    print('$_TAG:fetchGroup($groupId)');

    var dataModel = await cacheManager.getGroup(groupId);
    if (dataModel == null) {
      var response = await apiManager.fetchGroup(groupId);
      dataModel = response.data;
      cacheManager.setGroup(dataModel);
    }
    return ModelMapper.instance.fromGroupDataModel(dataModel);
  }

  @override
  Future<List<GroupViewModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchGroups');

    var response = await apiManager.fetchGroups(offset: offset, limit: limit);

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel));
  }

  @override
  Future<List<GroupViewModel>> fetchGroupsFromUser({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel));
  }

  @override
  Future<List<GroupViewModel>> fetchGroupsFromPart({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel));
  }

  ///
  /// Entries
  ///

  @override
  Future<EntryViewModel> fetchEntry(String entryId) async {
    print('$_TAG:fetchEntry($entryId)');

    var dataModel = await cacheManager.getEntry(entryId);
    if (dataModel == null) {
      var response = await apiManager.fetchEntry(entryId);
      dataModel = response.data;
      cacheManager.setEntry(dataModel);
    }
    return ModelMapper.instance.fromEntryDataModel(dataModel);
  }

  @override
  Future<List<EntryViewModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  }) async {
    print('$_TAG:fetchEntries');
    var response = await apiManager.fetchEntries(offset: offset, limit: limit);

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel));
  }

  @override
  Future<List<EntryViewModel>> fetchEntriesFromUser({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel));
  }

  @override
  Future<List<EntryViewModel>> fetchEntriesFromGroup({
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

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel));
  }

  ///
  /// Tools
  ///

  void _setCaches(List dataModels) {
    for (var model in dataModels) {
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
