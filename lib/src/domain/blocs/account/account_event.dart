import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  AccountEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class AccountRefresh extends AccountEvent {}
