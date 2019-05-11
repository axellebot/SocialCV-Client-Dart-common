import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/src/ui/models/cursor_model.dart';

mixin ElementListInitialized<T extends ElementViewModel> {
  String parentId;
  List<T> elements;
  String ownerId;
  Cursor cursor;

  @override
  String toString() =>
      '$ElementListInitialized<$T> { parentId: $parentId, elements: $elements, ownerId: $ownerId, cursor: $cursor }';
}

mixin ElementListRefresh<T extends ElementViewModel> {
  @override
  String toString() => '$ElementListRefresh {}';
}

mixin ElementListLoadMore<T extends ElementViewModel> {
  Cursor cursor;

  @override
  String toString() => '$ElementListRefresh { cursor: $cursor }';
}
