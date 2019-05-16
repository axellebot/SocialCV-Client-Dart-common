import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

mixin ElementListInitialized<T extends ElementViewModel> {
  String parentId;
  String ownerId;
  Cursor cursor;

  @override
  String toString() =>
      '$runtimeType{ parentId: $parentId, ownerId: $ownerId, cursor: $cursor }';
}

mixin ElementListRefresh<T extends ElementViewModel> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementListLoadMore<T extends ElementViewModel> {
  Cursor cursor;

  @override
  String toString() => '$runtimeType{ cursor: $cursor }';
}
