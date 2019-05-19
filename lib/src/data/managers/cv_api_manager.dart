import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class CVApiManager {
  ///
  /// OAuth
  ///

  Future<ResponseEnvelopOAuthAccessToken> fetchToken({
    @required String email,
    @required String password,
  });

  /// ----------------------------------------------------------
  /// ------------------------ Account -------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<UserDataModel>> fetchAccount();

  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  });

  /// ----------------------------------------------------------
  /// ------------------------- Users --------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<UserDataModel>> fetchUser(String userId);

  Future<ResponseEnvelopWithArray<UserDataModel>> fetchUsers({
    int offset = 0,
    int limit = 5,
  });

  /// ----------------------------------------------------------
  /// ----------------------- Profiles -------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<ProfileDataModel>> fetchProfile(String profileId);

  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfiles({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<ProfileDataModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  /// ----------------------------------------------------------
  /// ------------------------- Parts --------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<PartDataModel>> fetchPart(String partId);

  Future<ResponseEnvelopWithArray<PartDataModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<PartDataModel>> fetchPartsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<PartDataModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  });

  /// ----------------------------------------------------------
  /// ------------------------ Groups --------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<GroupDataModel>> fetchGroup(String groupId);

  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<GroupDataModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  });

  /// ----------------------------------------------------------
  /// ----------------------- Entries --------------------------
  /// ----------------------------------------------------------

  Future<ResponseEnvelop<EntryDataModel>> fetchEntry(String entryId);

  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<ResponseEnvelopWithArray<EntryDataModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  });

  @override
  String toString() => '$runtimeType{}';
}
