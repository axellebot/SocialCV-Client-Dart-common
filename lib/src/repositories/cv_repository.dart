import 'package:social_cv_client_dart_common/src/models/api_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_cache.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_client.dart';

const String _TAG = "CVRepository";

class CVRepository {
  const CVRepository({this.client, this.cache});

  final CVClient client;
  final CVCacheI cache;

  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> fetchToken({
    OAuthTokenModel oauthTokenModel,
  }) async {
    assert(oauthTokenModel != null);
    return await client.fetchToken(oauthTokenModel: oauthTokenModel);
  }

  ///
  /// Account
  ///

  Future<UserModel> fetchAccount() async {
    print("$_TAG:fetchAccount");

    UserModel userModel = await cache.getAccount();
    if (userModel == null) {
      userModel = (await client.fetchAccount()).data;
      cache.setAccount(userModel);
    }
    return userModel;
  }

  Future<List<ProfileModel>> fetchAccountProfiles({
    int offset = 0,
    int limit = 5,
  }) async {
    return (await client.fetchAccountProfiles(
      offset: offset,
      limit: offset,
    ))
        .data;
  }

  ///
  /// Profiles
  ///

  Future<ProfileModel> fetchProfile(String profileId,) async {
    ProfileModel profileModel = await cache.getProfile(profileId);
    if (profileModel == null) {
      profileModel = (await client.fetchProfile(profileId)).data;
      cache.setProfile(profileModel);
    }

    return profileModel;
  }

  Future<List<PartModel>> fetchProfileParts({
    String profileId,
    int offset = 0,
    int limit = 5,
  }) async {
    return (await client.fetchProfileParts(
      profileId: profileId,
      offset: offset,
      limit: offset,
    ))
        .data;
  }

  ///
  /// Parts
  ///

  Future<PartModel> fetchPart(String partId,) async {
    PartModel partModel = await cache.getPart(partId);
    if (partModel == null) {
      partModel = (await client.fetchPart(partId)).data;
      cache.setPart(partModel);
    }
    return partModel;
  }

  Future<List<GroupModel>> fetchPartGroups({
    String partId,
    int offset = 0,
    int limit = 5,
  }) async {
    return (await client.fetchPartGroups(
      partId: partId,
      offset: offset,
      limit: offset,
    ))
        .data;
  }

  ///
  /// Groups
  ///

  Future<GroupModel> fetchGroup(String groupId,) async {
    GroupModel groupModel = await cache.getGroup(groupId);
    if (groupModel == null)
      groupModel = (await client.fetchGroup(groupId)).data;
    return groupModel;
  }

  Future<List<EntryModel>> fetchGroupEntries({
    String groupId,
    int offset = 0,
    int limit = 5,
  }) async {
    return (await client.fetchGroupEntries(
      groupId: groupId,
      offset: offset,
      limit: offset,
    ))
        .data;
  }

  ///
  /// Entries
  ///

  Future<EntryModel> fetchEntry(String entryId,) async {
    EntryModel entryModel = await cache.getEntry(entryId);
    if (entryModel == null) {
      entryModel = (await client.fetchEntry(entryId)).data;
      cache.setEntry(entryModel);
    }
    return entryModel;
  }

  ///
  /// Profiles
  ///

  Future<List<ProfileModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 10,
  }) async {
    return (await client.fetchProfiles(
      profileTitle: profileTitle,
      offset: offset,
      limit: offset,
    ))
        .data;
  }
}
