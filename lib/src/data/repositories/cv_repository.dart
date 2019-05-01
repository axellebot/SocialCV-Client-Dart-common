import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class CVRepository {
  ///
  /// OAuth
  ///

  Future<AccessTokenViewModelModel> authenticate({
    @required String email,
    @required String password,
  });

  Future<AccessTokenViewModelModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  });

  ///
  /// Account
  ///

  Future<UserViewModel> fetchAccount();

  Future<List<ProfileViewModel>> fetchProfilesFromAccount({
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Profiles
  ///

  Future<ProfileViewModel> fetchProfile(String profileId);

  Future<List<ProfileViewModel>> fetchProfiles({
    String profileTitle,
    int offset = 0,
    int limit = 5,
  });

  Future<List<ProfileViewModel>> fetchProfilesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Parts
  ///

  Future<PartViewModel> fetchPart(String partId);

  Future<List<PartViewModel>> fetchParts({
    int offset = 0,
    int limit = 5,
  });

  Future<List<PartViewModel>> fetchPartsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<PartViewModel>> fetchPartsFromProfile({
    @required String profileId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Groups
  ///

  Future<GroupViewModel> fetchGroup(String groupId);

  Future<List<GroupViewModel>> fetchGroups({
    int offset = 0,
    int limit = 5,
  });

  Future<List<GroupViewModel>> fetchGroupsFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<GroupViewModel>> fetchGroupsFromPart({
    @required String partId,
    int offset = 0,
    int limit = 5,
  });

  ///
  /// Entries
  ///

  Future<EntryViewModel> fetchEntry(String entryId);

  Future<List<EntryViewModel>> fetchEntries({
    int offset = 0,
    int limit = 5,
  });

  Future<List<EntryViewModel>> fetchEntriesFromUser({
    @required String userId,
    int offset = 0,
    int limit = 5,
  });

  Future<List<EntryViewModel>> fetchEntriesFromGroup({
    @required String groupId,
    int offset = 0,
    int limit = 5,
  });
}
