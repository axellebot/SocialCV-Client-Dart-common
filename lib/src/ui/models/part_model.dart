import 'package:social_cv_client_dart_common/models.dart';

class PartViewModel extends ElementViewModel {
  String name;
  List<String> groupIds;
  String profileId;
  String type;
  String owner;

  PartViewModel({
    String id,
    this.name,
    this.groupIds,
    this.owner,
    this.profileId,
    this.type,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  @override
  String toString() =>
      'PartViewModel{ id: $id, name: $name, groupIds: $groupIds, profileId: $profileId, type: $type, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
