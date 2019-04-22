import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/api_data_models.dart';
import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

abstract class CVRepository {
  ///
  /// OAuth
  ///

  Future<OAuthAccessTokenResponseModel> authenticate({
    @required String email,
    @required String password,
  });

  Future<OAuthAccessTokenResponseModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  });

  ///
  /// Account
  ///

  Future<UserDataModel> fetchAccount();

  Future<List<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Profiles
  ///

  Future<ProfileDataModel> fetchProfile(String profileId);

  Future<List<ProfileDataModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 5,
  });

  Future<List<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Parts
  ///

  Future<PartDataModel> fetchPart(String partId);

  Future<List<PartDataModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  });

  Future<List<PartDataModel>> fetchPartsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Groups
  ///

  Future<GroupDataModel> fetchGroup(String groupId);

  Future<List<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  });

  Future<List<GroupDataModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<GroupDataModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Entries
  ///

  Future<EntryDataModel> fetchEntry(String entryId);

  Future<List<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  });

  Future<List<EntryDataModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<EntryDataModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  });
}
