import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class PartListState extends Equatable {
  PartListState([List props = const []]) : super(props);
}

class PartListUninitialized extends PartListState
    with ElementListUninitialized<PartViewModel> {
  PartListUninitialized() : super([]);

  @override
  String toString() => '$PartListUninitialized {}';
}

class PartListLoading extends PartListState
    with ElementListLoading<PartViewModel> {
  PartListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$PartListLoading { count: $count }';
}

class PartListLoaded extends PartListState
    with ElementListLoaded<PartViewModel> {
  PartListLoaded({@required List<PartViewModel> parts}) : super([parts]) {
    this.elements = parts;
  }

  @override
  String toString() => '$PartListLoaded { parts: $elements}';
}

class PartListFailure extends PartListState
    with ElementListFailure<PartViewModel> {
  PartListFailure({@required Error error}) : super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$PartListLoaded { error: $error}';
}
