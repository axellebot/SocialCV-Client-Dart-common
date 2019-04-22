import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

abstract class ElementListEvent<T extends ElementDataModel> extends Equatable {
  ElementListEvent([List props = const []]) : super(props);

  @override
  String toString() => 'CVElementListEvent<$T>';
}

class ElementListFetch<T extends ElementDataModel> extends ElementListEvent<T> {
  ElementListFetch({@required this.limit, @required this.offset})
      : super([limit, offset]);

  final int limit;
  final int offset;

  @override
  String toString() => 'ElementFetch<$T>';
}

class ElementListFetchFromParent<T extends ElementDataModel>
    extends ElementListEvent<T> {
  ElementListFetchFromParent({
    @required this.parentId,
    @required this.offset,
    @required this.limit,
  }) : super([parentId, offset, limit]);

  final String parentId;
  final int offset;
  final int limit;

  @override
  String toString() =>
      'ElementListFetchFromParent<$T> { parentId: $parentId, offset: $offset, limit: $limit}';
}
