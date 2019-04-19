import 'dart:async';

/// Interface for SecretRepository
abstract class ConfigRepository {
  Future<String> getClientId();

  Future<String> getClientSecret();
}
