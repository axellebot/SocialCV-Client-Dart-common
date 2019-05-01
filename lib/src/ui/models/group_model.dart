import 'package:social_cv_client_dart_common/models.dart';

class GroupViewModel extends ElementViewModel {
  String name;
  String type;
  List<String> entryIds;
  String partId;
  String owner;

  GroupViewModel({
    String id,
    this.name,
    this.type,
    this.entryIds,
    this.partId,
    this.owner,
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
      'GroupViewModel { id: $id, name: $name, type: $type, entryIds: $entryIds, partId: $partId, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
