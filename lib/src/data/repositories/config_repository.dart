import 'dart:async';

/// Interface for Configuration repositories
abstract class ConfigRepository {
  Future<String> getApiServerUrl();

  Future<String> getClientId();

  Future<String> getClientSecret();

  @override
  String toString() => '$runtimeType{}';
}
