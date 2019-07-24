import 'package:social_cv_client_dart_common/domain.dart';

abstract class ElementEntity extends BaseEntity {
  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
