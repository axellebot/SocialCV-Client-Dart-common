import 'package:social_cv_client_dart_common/models.dart';

class ProfileViewModel extends ElementViewModel {
  String title;
  String subtitle;
  Uri picture;
  Uri cover;
  String type;
  List<String> partIds;
  String owner;

  ProfileViewModel({
    String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.type,
    this.partIds,
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
      'ProfileViewModel { id: $id, title: $title, subtitle: $subtitle, picture: $picture, cover: $cover, type: $type, partIds: $partIds, owner: $owner, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
