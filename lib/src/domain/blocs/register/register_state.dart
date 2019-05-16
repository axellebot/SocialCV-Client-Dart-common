import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final Error error;

  RegisterFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$runtimeType{ error: $error }';
}

class RegisterSucceed extends RegisterState {
  final Object message;

  RegisterSucceed({@required this.message}) : super([message]);

  @override
  String toString() => '$runtimeType{ message: $message }';
}
