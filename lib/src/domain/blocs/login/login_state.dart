import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final Error error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: ${error.runtimeType} }';
}

class LoginSucceed extends LoginState {
  final Object message;

  LoginSucceed({@required this.message}) : super([message]);

  @override
  String toString() => '$runtimeType{ message: $message }';
}
