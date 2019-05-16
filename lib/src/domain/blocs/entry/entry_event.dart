import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class EntryEvent extends Equatable {
  EntryEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryInitialized extends EntryEvent
    with ElementInitialized<EntryViewModel> {
  final String _assertErrorMessage =
      '$EntryInitialized must be created with an $EntryViewModel or its ID';

  EntryInitialized({String withId, EntryViewModel withEntry})
      : assert(withId != null && withEntry == null, _assertErrorMessage),
        assert(withId == null && withEntry != null, _assertErrorMessage),
        super([withId, withEntry]) {
    this.elementId = withId;
    this.element = withEntry;
  }

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class EntryRefresh extends EntryEvent with ElementRefresh<EntryViewModel> {}
