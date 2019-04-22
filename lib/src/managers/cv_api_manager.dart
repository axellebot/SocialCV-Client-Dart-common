import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

abstract class CVApiManager {
  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> fetchToken({
    @required String email,
    @required String password,
  });

  ///
  /// Account
  ///

  Future<ResponseModel<UserDataModel>> fetchAccount();

  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Profiles
  ///

  Future<ResponseModel<ProfileDataModel>> fetchProfile(String profileId);

  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Parts
  ///

  Future<ResponseModel<PartDataModel>> fetchPart(String partId);

  Future<ResponseModelWithArray<PartDataModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<PartDataModel>> fetchPartsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Groups
  ///

  Future<ResponseModel<GroupDataModel>> fetchGroup(String groupId);

  Future<ResponseModelWithArray<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<GroupDataModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<GroupDataModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Entries
  ///

  Future<ResponseModel<EntryDataModel>> fetchEntry(String entryId);

  Future<ResponseModelWithArray<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<EntryDataModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseModelWithArray<EntryDataModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  });
}
