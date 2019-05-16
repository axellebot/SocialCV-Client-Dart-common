import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class EntryListState extends Equatable {
  EntryListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType';
}

class EntryListUninitialized extends EntryListState
    with ElementListUninitialized<EntryViewModel> {}

class EntryListLoading extends EntryListState
    with ElementListLoading<EntryViewModel> {
  EntryListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ count: $count }';
}

class EntryListLoaded extends EntryListState
    with ElementListLoaded<EntryViewModel> {
  EntryListLoaded({@required List<EntryViewModel> entries}) : super([entries]) {
    this.elements = entries;
  }

  @override
  String toString() => '$runtimeType{ entries: $elements}';
}

class EntryListFailure extends EntryListState
    with ElementListFailure<EntryViewModel> {
  EntryListFailure({@required Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ error: $error}';
}
