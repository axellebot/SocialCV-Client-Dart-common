/// Interface for SecretRepository
abstract class SecretsRepositoryI {
  Future<String> loadclientId();

  Future<String> loadclientSecret();
}