import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class PartEvent extends Equatable {
  PartEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartInitialized extends PartEvent with ElementInitialized<PartViewModel> {
  PartInitialized({String partId, PartViewModel part})
      : assert(
          partId != null && part == null,
          '$PartInitialized must be created with a $PartViewModel or its ID',
        ),
        assert(
          partId == null && part != null,
          '$PartInitialized must be created with a $PartViewModel or its ID',
        ),
        super([partId, part]) {
    this.elementId = partId;
    this.element = part;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, part: $element }';
}

class PartRefresh extends PartEvent with ElementRefresh<PartViewModel> {}
