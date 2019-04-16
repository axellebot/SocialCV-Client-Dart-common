import 'dart:async';

import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_cache.dart';
import 'package:social_cv_client_dart_common/src/repositories/cv_client.dart';

const String _TAG = "CVRepository";

abstract class CVRepository {
  Future<OAuthAccessTokenResponseModel> fetchToken({
    OAuthTokenModel oauthTokenModel,
  });

  ///
  /// Account
  ///

  Future<UserDataModel> fetchAccount();

  Future<List<ProfileDataModel>> fetchAccountProfiles({
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Profiles
  ///

  Future<ProfileDataModel> fetchProfile(
    String profileId,
  );

  Future<List<PartDataModel>> fetchProfileParts({
    String profileId,
    int offset,
    int limit,
  });

  ///
  /// Parts
  ///

  Future<PartDataModel> fetchPart(
    String partId,
  );

  Future<List<GroupDataModel>> fetchPartGroups({
    String partId,
    int offset,
    int limit,
  });

  ///
  /// Groups
  ///

  Future<GroupDataModel> fetchGroup(
    String groupId,
  );

  Future<List<EntryDataModel>> fetchGroupEntries({
    String groupId,
    int offset,
    int limit,
  });

  ///
  /// Entries
  ///

  Future<EntryDataModel> fetchEntry(
    String entryId,
  );

  ///
  /// Profiles
  ///

  Future<List<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset,
    int limit,
  });
}

/// Default Implementation of [CVRepository]
class CVRepositoryImpl extends CVRepository {
   CVRepositoryImpl({this.client, this.cache});

  final CVClientImpl client;
  final CVCache cache;

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

  Future<UserDataModel> fetchAccount() async {
    print("$_TAG:fetchAccount");

    UserDataModel userDataModel = await cache.getAccount();
    if (userDataModel == null) {
      userDataModel = (await client.fetchAccount()).data;
      cache.setAccount(userDataModel);
    }
    return userDataModel;
  }

  Future<List<ProfileDataModel>> fetchAccountProfiles({
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

  Future<ProfileDataModel> fetchProfile(
    String profileId,
  ) async {
    ProfileDataModel profileModel = await cache.getProfile(profileId);
    if (profileModel == null) {
      profileModel = (await client.fetchProfile(profileId)).data;
      cache.setProfile(profileModel);
    }

    return profileModel;
  }

  Future<List<PartDataModel>> fetchProfileParts({
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

  Future<PartDataModel> fetchPart(
    String partId,
  ) async {
    PartDataModel partModel = await cache.getPart(partId);
    if (partModel == null) {
      partModel = (await client.fetchPart(partId)).data;
      cache.setPart(partModel);
    }
    return partModel;
  }

  Future<List<GroupDataModel>> fetchPartGroups({
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

  Future<GroupDataModel> fetchGroup(
    String groupId,
  ) async {
    GroupDataModel groupModel = await cache.getGroup(groupId);
    if (groupModel == null)
      groupModel = (await client.fetchGroup(groupId)).data;
    return groupModel;
  }

  Future<List<EntryDataModel>> fetchGroupEntries({
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

  Future<EntryDataModel> fetchEntry(
    String entryId,
  ) async {
    EntryDataModel entryModel = await cache.getEntry(entryId);
    if (entryModel == null) {
      entryModel = (await client.fetchEntry(entryId)).data;
      cache.setEntry(entryModel);
    }
    return entryModel;
  }

  ///
  /// Profiles
  ///

  Future<List<ProfileDataModel>> fetchProfiles({
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
