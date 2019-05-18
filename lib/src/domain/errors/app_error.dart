import 'package:social_cv_client_dart_common/src/domain/errors/base_errors.dart';

class NotImplementedYetError extends BaseError {
  NotImplementedYetError() : super('NotImplementedYetError');
}

/// ----------------------------------------------------------
/// ----------------------- Application ----------------------
/// ----------------------------------------------------------

class ApplicationError extends BaseError {
  ApplicationError() : super('ApplicationError');
}

/// ----------------------------------------------------------
/// ---------------------- Authentication --------------------
/// ----------------------------------------------------------
class AuthenticationError extends BaseError {
  AuthenticationError() : super('AuthenticationError');
}
