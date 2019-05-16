import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

/// Default Implementation of [CVRepository]
class DefaultCloudCVRepository extends CVRepository {
  final String _tag = '$DefaultCloudCVRepository';

  final CVApiManager cvApiManager;
  final CVCacheManager cvCacheManager;

  DefaultCloudCVRepository({
    @required this.cvApiManager,
    @required this.cvCacheManager,
  })  : assert(cvApiManager != null, 'Missing $CVApiManager'),
        assert(cvCacheManager != null, 'Missing $CVCacheManager');

  ///
  /// OAuth
  ///

  @override
  Future<AccessTokenViewModelModel> authenticate({
    @required String email,
    @required String password,
  }) async {
    print('$_tag:$authenticate');
    assert(email != null && password != null);

    var response =
        await cvApiManager.fetchToken(email: email, password: password);
    return ModelMapper.instance.fromOAuthAccessToken(response);
  }

  Future<AccessTokenViewModelModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  }) async {
    print('$_tag:$register');
    assert(fName != null && lName != null && email != null && password != null);

    throw NotImplementedYetError();
//    return ModelMapper.instance.fromOAuthAccessToken(reponse);
  }

  ///
  /// Account
  ///

  @override
  Future<UserViewModel> fetchAccount() async {
    print('$_tag:$fetchAccount');

    var dataModel = await cvCacheManager.getAccount();

    if (dataModel == null) {
      var response = await cvApiManager.fetchAccount();
      var model = response.data;
      cvCacheManager.setAccount(model);
    }

    return ModelMapper.instance.fromUserDataModel(dataModel);
  }

  @override
  Future<List<ProfileViewModel>> fetchProfilesFromAccount({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchProfilesFromAccount');

    var response = await cvApiManager.fetchProfilesFromAccount(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map(
            (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel))
        .toList();
  }

  ///
  /// Users
  ///

  @override
  Future<UserViewModel> fetchUser(
    String userId, {
    force = false,
  }) async {
    print('$_tag:$fetchUser($userId)');
    assert(userId != null);

    var dataModel;

    if (!force) dataModel = await cvCacheManager.getUser(userId);

    if (dataModel == null) {
      var response = await cvApiManager.fetchUser(userId);
      dataModel = response.data;
      cvCacheManager.setUser(dataModel);
    }

    return ModelMapper.instance.fromUserDataModel(dataModel);
  }

  @override
  Future<List<UserViewModel>> fetchUsers({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchUsers');

    var response = await cvApiManager.fetchUsers(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromUserDataModel(dataModel))
        .toList();
  }

  ///
  /// Profiles
  ///

  @override
  Future<ProfileViewModel> fetchProfile(
    String profileId, {
    force = false,
  }) async {
    print('$_tag:$fetchProfile($profileId)');
    assert(profileId != null);

    var dataModel;

    if (!force) dataModel = await cvCacheManager.getProfile(profileId);

    if (dataModel == null) {
      var response = await cvApiManager.fetchProfile(profileId);
      dataModel = response.data;
      cvCacheManager.setProfile(dataModel);
    }

    return ModelMapper.instance.fromProfileDataModel(dataModel);
  }

  @override
  Future<List<ProfileViewModel>> fetchProfiles({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchProfiles');

    var response = await cvApiManager.fetchProfiles(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map(
            (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<ProfileViewModel>> fetchProfilesFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchProfilesFromUser($userId)');
    assert(userId != null);

    var response = await cvApiManager.fetchProfilesFromUser(
      userId: userId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map(
            (dataModel) => ModelMapper.instance.fromProfileDataModel(dataModel))
        .toList();
  }

  ///
  /// Parts
  ///

  @override
  Future<PartViewModel> fetchPart(String partId, {force = false}) async {
    print('$_tag:$fetchPart($partId)');

    var dataModel;

    if (!force) dataModel = await cvCacheManager.getPart(partId);

    if (dataModel == null) {
      var response = await cvApiManager.fetchPart(partId);
      dataModel = response.data;
      cvCacheManager.setPart(dataModel);
    }

    return ModelMapper.instance.fromPartDataModel(dataModel);
  }

  @override
  Future<List<PartViewModel>> fetchParts({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchParts');

    var response = await cvApiManager.fetchParts(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<PartViewModel>> fetchPartsFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchPartsFromUser($userId)');
    assert(userId != null);

    var response = await cvApiManager.fetchPartsFromUser(
      userId: userId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<PartViewModel>> fetchPartsFromProfile({
    @required String profileId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchPartsFromProfile');
    assert(profileId != null);

    var response = await cvApiManager.fetchPartsFromProfile(
      profileId: profileId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromPartDataModel(dataModel))
        .toList();
  }

  ///
  /// Groups
  ///

  @override
  Future<GroupViewModel> fetchGroup(
    String groupId, {
    force = false,
  }) async {
    print('$_tag:$fetchGroup($groupId)');
    assert(groupId != null);

    var dataModel;

    if (!force) dataModel = await cvCacheManager.getGroup(groupId);

    if (dataModel == null) {
      var response = await cvApiManager.fetchGroup(groupId);
      dataModel = response.data;
      cvCacheManager.setGroup(dataModel);
    }
    return ModelMapper.instance.fromGroupDataModel(dataModel);
  }

  @override
  Future<List<GroupViewModel>> fetchGroups({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchGroups');

    var response = await cvApiManager.fetchGroups(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<GroupViewModel>> fetchGroupsFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchGroupsFromUser($userId)');
    assert(userId != null);

    var response = await cvApiManager.fetchGroupsFromUser(
      userId: userId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<GroupViewModel>> fetchGroupsFromPart({
    @required String partId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchGroupsFromPart($partId)');
    assert(partId != null);

    var response = await cvApiManager.fetchGroupsFromPart(
      partId: partId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromGroupDataModel(dataModel))
        .toList();
  }

  ///
  /// Entries
  ///

  @override
  Future<EntryViewModel> fetchEntry(
    String entryId, {
    force = false,
  }) async {
    print('$_tag:$fetchEntry($entryId)');
    assert(entryId != null);

    var dataModel;

    if (!force) dataModel = await cvCacheManager.getEntry(entryId);

    if (dataModel == null) {
      var response = await cvApiManager.fetchEntry(entryId);
      dataModel = response.data;
      cvCacheManager.setEntry(dataModel);
    }

    return ModelMapper.instance.fromEntryDataModel(dataModel);
  }

  @override
  Future<List<EntryViewModel>> fetchEntries({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchEntries');

    var response = await cvApiManager.fetchEntries(
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<EntryViewModel>> fetchEntriesFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchEntriesFromUser($userId)');
    assert(userId != null);

    var response = await cvApiManager.fetchEntriesFromUser(
      userId: userId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel))
        .toList();
  }

  @override
  Future<List<EntryViewModel>> fetchEntriesFromGroup({
    @required String groupId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  }) async {
    print('$_tag:$fetchEntriesFromGroup($groupId)');
    assert(groupId != null);

    var response = await cvApiManager.fetchEntriesFromGroup(
      groupId: groupId,
      offset: cursor.offset,
      limit: cursor.limit,
    );

    var dataModels = response.data;

    _setCaches(dataModels);

    return dataModels
        .map((dataModel) => ModelMapper.instance.fromEntryDataModel(dataModel))
        .toList();
  }

  ///
  /// Tools
  ///

  void _setCaches(List dataModels) {
    for (var model in dataModels) {
      if (model is UserDataModel) {
        cvCacheManager.setUser(model);
      } else if (model is ProfileDataModel) {
        cvCacheManager.setProfile(model);
      } else if (model is PartDataModel) {
        cvCacheManager.setPart(model);
      } else if (model is GroupDataModel) {
        cvCacheManager.setGroup(model);
      } else if (model is EntryDataModel) {
        cvCacheManager.setEntry(model);
      }
    }
  }

  Cursor _checkCursor(Cursor cursor) {
    if (cursor == null) {
      cursor = Cursor();
    }
    return cursor;
  }
}
