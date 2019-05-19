import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

/// [EntryEvent] that must be dispatch to [EntryBloc]
abstract class EntryEvent extends Equatable {
  EntryEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class EntryInitialized extends EntryEvent
    with ElementInitialized<EntryViewModel> {
  EntryInitialized({String entryId, EntryViewModel entry})
      : assert(
          entryId != null && entry == null,
          '$EntryInitialized must be created with an $EntryViewModel or its ID',
        ),
        assert(
          entryId == null && entry != null,
          '$EntryInitialized must be created with an $EntryViewModel or its ID',
        ),
        super([entryId, entry]) {
    this.elementId = entryId;
    this.element = entry;
  }

  @override
  String toString() => '$runtimeType{ entryId: $elementId, element: $element }';
}

class EntryRefresh extends EntryEvent with ElementRefresh<EntryViewModel> {}
