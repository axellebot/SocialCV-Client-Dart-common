import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class EntryEvent extends Equatable {
  EntryEvent([List props = const []]) : super(props);
}

class EntryInitialized extends EntryEvent
    with ElementInitialized<EntryViewModel> {
  EntryInitialized({String withId, EntryViewModel withEntry})
      : assert(
          (withId != null && withEntry == null) ||
              (withId == null && withEntry != null),
          '$EntryInitialized must be created with an $EntryViewModel or its ID',
        ),
        super([withId, withEntry]) {
    this.elementId = withId;
    this.element = withEntry;
  }

  @override
  String toString() =>
      '$EntryInitialized { id: $elementId, element: $element }';
}

class EntryRefresh extends EntryEvent with ElementRefresh<EntryViewModel> {
  EntryRefresh() : super([]);

  @override
  String toString() => '$EntryRefresh {}';
}
