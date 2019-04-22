import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/src/models/element_data_model.dart';

abstract class ElementEvent<T extends ElementDataModel> extends Equatable {
  ElementEvent([List props = const []]) : super(props);
}

class ElementFetch<T extends ElementDataModel> extends ElementEvent<T> {
  ElementFetch({@required this.id}) : super([id]);

  String id;

  @override
  String toString() => 'ElementFetch<$T>{id: $id}';
}
