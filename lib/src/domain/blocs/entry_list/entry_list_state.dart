import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class EntryListState extends Equatable {
  EntryListState([List props = const []]) : super(props);
}

class EntryListUninitialized extends EntryListState
    with ElementListUninitialized<EntryViewModel> {
  EntryListUninitialized() : super([]);

  @override
  String toString() => '$EntryListUninitialized {}';
}

class EntryListLoading extends EntryListState
    with ElementListLoading<EntryViewModel> {
  EntryListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$EntryListLoading { count: $count }';
}

class EntryListLoaded extends EntryListState
    with ElementListLoaded<EntryViewModel> {
  EntryListLoaded({@required List<EntryViewModel> entries}) : super([entries]) {
    this.elements = entries;
  }

  @override
  String toString() => '$EntryListLoaded { entries: $elements}';
}

class EntryListFailure extends EntryListState
    with ElementListFailure<EntryViewModel> {
  EntryListFailure({@required Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$EntryListFailure { error: $error}';
}
