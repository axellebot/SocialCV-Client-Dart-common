import 'package:json_annotation/json_annotation.dart';
import 'package:social_cv_client_dart_common/src/models/base_data_model.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends BaseDataModel {
  UserDataModel({
    String id,
    this.disabled,
    this.email,
    this.username,
    this.picture,
    this.profileIds,
    this.permission,
  }) : super(id: id);

  bool disabled;
  String email;
  String username;
  String picture;

  @JsonKey(name: 'profiles')
  List<String> profileIds;

  dynamic permission;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  @override
  String toString() {
    return 'UserDataModel{disabled: $disabled, email: $email, username: $username, picture: $picture, profileIds: $profileIds, permission: $permission}';
  }
}
