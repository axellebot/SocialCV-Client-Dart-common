/// Interface for SecretRepository
abstract class SecretsRepository {
  Future<String> loadclientId();

  Future<String> loadclientSecret();
}