import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class RegisterButtonPressed extends RegisterEvent {
  final String fName;
  final String lName;
  final String email;
  final String password;

  RegisterButtonPressed({
    @required this.fName,
    @required this.lName,
    @required this.email,
    @required this.password,
  }) : super([fName, lName, email, password]);

  @override
  String toString() =>
      '$RegisterButtonPressed { fName: $fName, lName: $lName, email: $email, password: $password }';
}
