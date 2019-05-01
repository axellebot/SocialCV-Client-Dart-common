import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ElementEvent<T extends ElementViewModel> extends Equatable {
  ElementEvent([List props = const []]) : super(props);
}

class ElementFetch<T extends ElementViewModel> extends ElementEvent<T> {
  final String id;

  ElementFetch({@required this.id})
      : assert(id != null, 'No id given'),
        super([id]);

  @override
  String toString() => 'ElementFetch<$T>{id: $id}';
}
