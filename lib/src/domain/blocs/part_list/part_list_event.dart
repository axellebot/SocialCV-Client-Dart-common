import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

abstract class PartListEvent extends Equatable {
  PartListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartListInitialized extends PartListEvent
    with ElementListInitialized<PartViewModel> {
  PartListInitialized({
    String parentProfileId,
    String ownerId,
    Cursor cursor,
  })  : assert(
          parentProfileId != null && ownerId == null,
          '$PartListInitialized must be created with a parentId or an ownerId',
        ),
        assert(
          parentProfileId == null && ownerId != null,
          '$PartListInitialized must be created with a parentId or an ownerId',
        ),
        super([parentProfileId, ownerId]) {
    this.parentId = parentProfileId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  String toString() =>
      '$runtimeType{ parentProfileId: $parentId, ownerId: $ownerId, cursor: $cursor }';
}

class PartListRefresh extends PartListEvent
    with ElementListRefresh<PartViewModel> {}

class PartListLoadMore extends PartListEvent
    with ElementListLoadMore<PartViewModel> {
  PartListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$runtimeType{ cursor: $cursor }';
}
