import 'dart:async';

import 'package:social_cv_client_dart_common/src/models/entry_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/group_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/part_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/profile_data_model.dart';
import 'package:social_cv_client_dart_common/src/models/user_data_model.dart';

/// Interface for CVCache (depends on the platform flutter/angular/...)
abstract class CVCacheManager {
  ///
  /// Account
  ///

  Future<UserDataModel> getAccount();

  void setAccount(UserDataModel userModel);

  ///
  /// Users
  ///

  Future<UserDataModel> getUser(String userId);

  void setUser(UserDataModel userModel);

  ///
  /// Profiles
  ///

  Future<ProfileDataModel> getProfile(String profileId);

  void setProfile(ProfileDataModel profileModel);

  ///
  /// Parts
  ///

  Future<PartDataModel> getPart(String partId);

  void setPart(PartDataModel partModel);

  ///
  /// Groups
  ///

  Future<GroupDataModel> getGroup(String groupId);

  void setGroup(GroupDataModel groupModel);

  ///
  /// Entries
  ///

  Future<EntryDataModel> getEntry(String entryId);

  void setEntry(EntryDataModel entryModel);
}
