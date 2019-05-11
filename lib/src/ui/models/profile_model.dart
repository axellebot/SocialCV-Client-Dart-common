import 'package:social_cv_client_dart_common/models.dart';

class ProfileViewModel extends ElementViewModel {
  String title;
  String subtitle;
  Uri picture;
  Uri cover;
  String type;
  List<String> partIds;
  String ownerId;

  ProfileViewModel({
    String id,
    this.title,
    this.subtitle,
    this.picture,
    this.cover,
    this.partIds,
    this.type,
    this.ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          version: version,
        );

  ProfileViewModel copyWith({
    String id,
    String title,
    String subtitle,
    Uri picture,
    Uri cover,
    List<String> partIds,
    String type,
    String ownerId,
    DateTime createdAt,
    DateTime updatedAt,
    int version,
  }) {
    return ProfileViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      picture: picture ?? this.picture,
      cover: cover ?? this.cover,
      partIds: partIds ?? this.partIds,
      type: type ?? this.type,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() =>
      '$ProfileViewModel { id: $id, title: $title, subtitle: $subtitle, picture: $picture, cover: $cover, type: $type, partIds: $partIds, owner: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, version: $version }';
}
