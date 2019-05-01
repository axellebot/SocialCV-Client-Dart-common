import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ElementListEvent<T extends ElementViewModel> extends Equatable {
  ElementListEvent([List props = const []]) : super(props);

  @override
  String toString() => 'CVElementListEvent<$T>';
}

class ElementListFetch<T extends ElementViewModel> extends ElementListEvent<T> {
  final int offset;
  final int limit;

  ElementListFetch({@required this.offset, @required this.limit})
      : super([offset, limit]);

  @override
  String toString() => 'ElementFetch<$T> { offset: $offset, limit: $limit}';
}

class ElementListFetchFromParent<T extends ElementViewModel>
    extends ElementListEvent<T> {
  final String parentId;
  final int offset;
  final int limit;

  ElementListFetchFromParent({
    @required this.parentId,
    @required this.offset,
    @required this.limit,
  }) : super([parentId, offset, limit]);

  @override
  String toString() =>
      'ElementListFetchFromParent<$T> { parentId: $parentId, offset: $offset, limit: $limit }';
}
