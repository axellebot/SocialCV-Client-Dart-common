import 'package:social_cv_client_dart_common/models.dart';

/// [ModelMapper] for MVVM pattern
class ModelMapper {
  final String _tag = '$ModelMapper';

  static ModelMapper _instance;

  static _initState() {
    _instance = ModelMapper();
  }

  static ModelMapper get instance {
    if (_instance == null) {
      _initState();
    }
    return _instance;
  }

  /// [ResponseEnvelopOAuthAccessToken] to [AccessTokenViewModelModel]
  AccessTokenViewModelModel fromOAuthAccessToken(
      ResponseEnvelopOAuthAccessToken dataModel) {
    return AccessTokenViewModelModel(
      accessToken: dataModel.accessToken,
      refreshToken: dataModel.refreshToken,
      accessTokenExpiresAt: dataModel.accessTokenExpiresAt,
      tokenType: dataModel.tokenType,
    );
  }

  /// [UserDataModel] to [UserViewModel]
  UserViewModel fromUserDataModel(UserDataModel dataModel) {
    return UserViewModel(
      id: dataModel.id,
      disabled: dataModel.disabled,
      username: dataModel.username,
      email: dataModel.email,
      picture: dataModel.picture,
      profileIds: dataModel.profileIds,
      permission: dataModel.permission,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [ProfileDataModel] to [ProfileViewModel]
  ProfileViewModel fromProfileDataModel(ProfileDataModel dataModel) {
    /// TODO: Map Profile type with enum
    return ProfileViewModel(
      id: dataModel.id,
      title: dataModel.title,
      subtitle: dataModel.subtitle,
      picture: dataModel.picture,
      cover: dataModel.cover,
      partIds: dataModel.partIds,
      type: dataModel.type,
      ownerId: dataModel.ownerId,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [PartDataModel] to [PartViewModel]
  PartViewModel fromPartDataModel(PartDataModel dataModel) {
    /// TODO: Map Part type with enum
    return PartViewModel(
      id: dataModel.id,
      name: dataModel.name,
      groupIds: dataModel.groupIds,
      type: dataModel.type,
      ownerId: dataModel.ownerId,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [GroupDataModel] to [GroupViewModel]
  GroupViewModel fromGroupDataModel(GroupDataModel dataModel) {
    /// TODO: Map Group type with enum
    return GroupViewModel(
      id: dataModel.id,
      name: dataModel.name,
      entryIds: dataModel.entryIds,
      type: dataModel.type,
      ownerId: dataModel.ownerId,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [EntryDataModel] to [EntryViewModel]
  EntryViewModel fromEntryDataModel(EntryDataModel dataModel) {
    /// TODO: Map Entry type with enum
    return EntryViewModel(
      id: dataModel.id,
      name: dataModel.name,
      content: dataModel.content,
      startDate: dataModel.startDate,
      endDate: dataModel.endDate,
      location: dataModel.location,
      type: dataModel.type,
      ownerId: dataModel.ownerId,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  @override
  String toString() => '$runtimeType{}';
}
