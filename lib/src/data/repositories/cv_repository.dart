import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class CVRepository {
  /// ----------------------------------------------------------
  /// ------------------------- OAuth --------------------------
  /// ----------------------------------------------------------

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

  /// ----------------------------------------------------------
  /// ------------------------ Account -------------------------
  /// ----------------------------------------------------------

  Future<UserViewModel> fetchAccount();

  Future<List<ProfileViewModel>> fetchProfilesFromAccount({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------- Users --------------------------
  /// ----------------------------------------------------------

  Future<UserViewModel> fetchUser(String userId, {force = false});

  Future<List<UserViewModel>> fetchUsers({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ----------------------- Profiles -------------------------
  /// ----------------------------------------------------------

  Future<ProfileViewModel> fetchProfile(
    String profileId, {
    force = false,
  });

  Future<List<ProfileViewModel>> fetchProfiles({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<ProfileViewModel>> fetchProfilesFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------- Parts --------------------------
  /// ----------------------------------------------------------

  Future<PartViewModel> fetchPart(
    String partId, {
    force = false,
  });

  Future<List<PartViewModel>> fetchParts({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<PartViewModel>> fetchPartsFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<PartViewModel>> fetchPartsFromProfile({
    @required String profileId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------ Groups --------------------------
  /// ----------------------------------------------------------

  Future<GroupViewModel> fetchGroup(
    String groupId, {
    force = false,
  });

  Future<List<GroupViewModel>> fetchGroups({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<GroupViewModel>> fetchGroupsFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<GroupViewModel>> fetchGroupsFromPart({
    @required String partId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ----------------------- Entries --------------------------
  /// ----------------------------------------------------------

  Future<EntryViewModel> fetchEntry(
    String entryId, {
    force = false,
  });

  Future<List<EntryViewModel>> fetchEntries({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<EntryViewModel>> fetchEntriesFromUser({
    @required String userId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  Future<List<EntryViewModel>> fetchEntriesFromGroup({
    @required String groupId,

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------- Misc ---------------------------
  /// ----------------------------------------------------------

  @override
  String toString() => '$runtimeType{}';
}
