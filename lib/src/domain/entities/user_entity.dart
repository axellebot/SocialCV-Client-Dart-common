import 'package:social_cv_client_dart_common/domain.dart';

abstract class UserEntity extends ElementEntity {
  String email;
  String username;
  bool disabled;
  String picture;
  List<String> profileIds;
  dynamic permission;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'disabled: $disabled, '
      'email: $email, '
      'username: $username, '
      'picture: $picture, '
      'profileIds: $profileIds, '
      'permission: $permission'
      ' }';
}
