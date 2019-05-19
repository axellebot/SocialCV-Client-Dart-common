import 'dart:async';

/// Interface for all configuration repositories
/// Mostly only one local configuration repository is needed
abstract class ConfigRepository {
  /// Get Api server url ([String])
  Future<String> getApiServerUrl();

  /// Get client id ([String])
  Future<String> getClientId();

  /// Get client secret ([String])
  Future<String> getClientSecret();

  @override
  String toString() => '$runtimeType{}';
}
