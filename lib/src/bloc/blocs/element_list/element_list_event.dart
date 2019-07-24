import 'package:social_cv_client_dart_common/domain.dart';
import 'package:social_cv_client_dart_common/presentation.dart';

mixin ElementListInitialized<T extends ElementEntity> {
  String parentId;
  String ownerId;
  Cursor cursor;

  @override
  String toString() => '$runtimeType{ '
      'parentId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

mixin ElementListRefresh<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementListLoadMore<T extends ElementEntity> {
  Cursor cursor;

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
