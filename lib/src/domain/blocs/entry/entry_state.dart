import 'package:equatable/equatable.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class EntryState extends Equatable {
  EntryState([List props = const []]) : super(props);
}

class EntryUninitialized extends EntryState
    with ElementUninitialized<EntryViewModel> {
  EntryUninitialized() : super([]);

  @override
  String toString() => '$EntryUninitialized {}';
}

class EntryLoading extends EntryState with ElementLoading<EntryViewModel> {
  EntryLoading() : super([]);

  @override
  String toString() => '$EntryLoading {}';
}

class EntryLoaded extends EntryState with ElementLoaded<EntryViewModel> {
  EntryLoaded({EntryViewModel entry}) : super([entry]) {
    this.element = entry;
  }

  @override
  String toString() {
    return '$EntryLoaded { element: $element }';
  }
}

class EntryFailure extends EntryState with ElementFailure<EntryViewModel> {
  EntryFailure({Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$EntryFailure { $error: $error }';
}
