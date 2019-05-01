import 'dart:async';

/// Interface for SecretRepository
abstract class ConfigRepository {
  Future<String> getApiServerUrl();

  Future<String> getClientId();

  Future<String> getClientSecret();
}
