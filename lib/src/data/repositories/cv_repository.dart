import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class CVRepository {
  /// ----------------------------------------------------------
  /// -------------------------- Auth --------------------------
  /// ----------------------------------------------------------

  /// Authenticate
  ///
  /// Must use [email] and [password] to authenticate an user
  ///
  /// Must return an [AccessTokenViewModelModel]
  Future<AccessTokenViewModelModel> authenticate({
    @required String email,
    @required String password,
  });

  /// Register
  ///
  /// Must use [fName], [lName], [email] and [password] to register an user
  ///
  /// Must return an [AccessTokenViewModelModel]
  Future<AccessTokenViewModelModel> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  });

  /// ----------------------------------------------------------
  /// ------------------------ Account -------------------------
  /// ----------------------------------------------------------

  /// Fetch information of the authenticated user
  ///
  /// Must return an [UserViewModel]
  Future<UserViewModel> fetchAccount();

  /// Fetch profiles from the authenticated user account
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [ProfileViewModel]
  Future<List<ProfileViewModel>> fetchProfilesFromAccount({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------- Users --------------------------
  /// ----------------------------------------------------------

  /// Fetch the user identified by [userId]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [UserViewModel]
  Future<UserViewModel> fetchUser(String userId, {force = false});

  /// Fetch users
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [UserViewModel]
  Future<List<UserViewModel>> fetchUsers({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ----------------------- Profiles -------------------------
  /// ----------------------------------------------------------

  /// Fetch the profile identified by [profileId]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [ProfileViewModel]
  Future<ProfileViewModel> fetchProfile(
    String profileId, {
    force = false,
  });

  /// Fetch profiles
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [ProfileViewModel]
  Future<List<ProfileViewModel>> fetchProfiles({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch profiles from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [ProfileViewModel]
  Future<List<ProfileViewModel>> fetchProfilesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------- Parts --------------------------
  /// ----------------------------------------------------------

  /// Fetch the part identified by [partId]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [PartViewModel]
  Future<PartViewModel> fetchPart(
    String partId, {
    force = false,
  });

  /// Fetch parts
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [PartViewModel]
  Future<List<PartViewModel>> fetchParts({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch parts from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [PartViewModel]
  Future<List<PartViewModel>> fetchPartsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch parts from the parent profile identified by [profileId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [PartViewModel]
  Future<List<PartViewModel>> fetchPartsFromProfile(
    String profileId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ------------------------ Groups --------------------------
  /// ----------------------------------------------------------

  /// Fetch the group identified by [groupId]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [GroupViewModel]
  Future<GroupViewModel> fetchGroup(
    String groupId, {
    force = false,
  });

  /// Fetch groups
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [GroupViewModel]
  Future<List<GroupViewModel>> fetchGroups({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch groups from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [GroupViewModel]
  Future<List<GroupViewModel>> fetchGroupsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch groups from the parent part identified by [partId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [GroupViewModel]
  Future<List<GroupViewModel>> fetchGroupsFromPart(
    String partId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// ----------------------------------------------------------
  /// ----------------------- Entries --------------------------
  /// ----------------------------------------------------------

  /// Fetch the entry identified by the [entryId]
  ///
  /// [force] can be used to avoid cache use ([$false] by default)
  ///
  /// Must return an [EntryViewModel]
  Future<EntryViewModel> fetchEntry(
    String entryId, {
    force = false,
  });

  /// Fetch entries
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [EntryViewModel]
  Future<List<EntryViewModel>> fetchEntries({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch groups from the user identified by [userId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [EntryViewModel]
  Future<List<EntryViewModel>> fetchEntriesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  /// Fetch groups from the parent group identified by [groupId]
  ///
  /// [Cursor] can be used to choose the offset and the limit
  ///
  /// Must return a [List] of [EntryViewModel]
  Future<List<EntryViewModel>> fetchEntriesFromGroup(
    String groupId, {

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
