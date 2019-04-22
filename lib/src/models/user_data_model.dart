import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends ElementDataModel {
  UserDataModel({
    String id,
    this.disabled,
    this.email,
    this.username,
    this.picture,
    this.profileIds,
    this.permission,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  @JsonKey(name: 'disabled')
  bool disabled;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'picture')
  String picture;
  @JsonKey(name: 'profiles')
  List<String> profileIds;
  @JsonKey(name: 'permission')
  dynamic permission;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  @override
  String toString() =>
      'UserDataModel { id: $id, disabled: $disabled, email: $email, username: $username, picture: $picture, profileIds: $profileIds, permission: $permission}';
}
