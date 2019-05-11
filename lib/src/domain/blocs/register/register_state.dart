import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => '$RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => '$RegisterLoading';
}

class RegisterFailure extends RegisterState {
  final Error error;

  RegisterFailure({@required this.error}) : super([error]);

  @override
  String toString() => '$RegisterFailure { error: $error }';
}

class RegisterSucceed extends RegisterState {
  final Object message;

  RegisterSucceed({@required this.message}) : super([message]);

  @override
  String toString() => '$RegisterSucceed { message: $message }';
}
