import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  AccountEvent([List props = const []]) : super(props);
}

class AccountRefresh extends AccountEvent {
  @override
  String toString() => 'AccountRefresh';
}
