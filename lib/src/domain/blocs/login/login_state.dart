import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() => '$LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => '$LoginLoading';
}

class LoginFailure extends LoginState {
  final Error error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$LoginFailure { error: $error }';
}

class LoginSucceed extends LoginState {
  final Object message;

  LoginSucceed({@required this.message}) : super([message]);

  @override
  String toString() => '$LoginSucceed { message: $message }';
}
