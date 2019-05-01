import 'package:social_cv_client_dart_common/models.dart';

class EntryViewModel extends ElementViewModel {
  String name;
  String type;
  dynamic content;
  String startDate;
  String endDate;
  String location;
  String groupId;
  String owner;

  EntryViewModel({
    String id,
    this.name,
    this.type,
    this.content,
    this.startDate,
    this.endDate,
    this.location,
    this.groupId,
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
      'EntryViewModel { id: $id, name: $name, type: $type, content: $content, startDate: $startDate, endDate: $endDate, location: $location, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
