import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class PartEvent extends Equatable {
  PartEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartInitialized extends PartEvent with ElementInitialized<PartViewModel> {
  PartInitialized({String withId, PartViewModel withPart})
      : assert(
            (withId != null && withPart == null) ||
                (withId == null && withPart != null),
            '$PartInitialized must be created with an $PartViewModel or its ID'),
        super([withId, withPart]) {
    this.elementId = withId;
    this.element = withPart;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class PartRefresh extends PartEvent with ElementRefresh<PartViewModel> {}
