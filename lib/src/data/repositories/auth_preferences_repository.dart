/// Interface for all authentication preferences repository
/// Mostly only one local authentication preferences repository is needed
abstract class AuthPreferencesRepository {
  /// Set access token ([String])
  Future<void> setAccessToken(String accessToken);

  /// Get access token
  ///
  /// Must return a access token ([String]) or [null] otherwise
  Future<String> getAccessToken();

  /// Delete access token
  Future<void> deleteAccessToken();

  /// Set access token expiration datetime as timestamp ([int])
  Future<void> setAccessTokenExpiration(int accessTokenExpiration);

  /// Get access token expiration time
  ///
  /// Must return the access token expiration datetime as timestamp ([int])
  /// or [null] otherwise
  Future<int> getAccessTokenExpiration();

  /// Delete access token expiration datetime
  Future<void> deleteAccessTokenExpiration();

  /// Set refresh token ([String])
  Future<void> setRefreshToken(String refreshToken);

  /// Get refresh token
  ///
  /// Must return a refresh token ([String]) or [null] otherwise
  Future<String> getRefreshToken();

  /// Delete refresh token
  Future<void> deleteRefreshToken();

  /// Set refresh token expiration datetime as timestamp ([int])
  Future<void> setRefreshTokenExpiration(int refreshTokenExpiration);

  /// Get refresh token expiration datetime
  ///
  /// Must return the access token expiration datetime as timestamp ([int])
  /// or [null] otherwise
  Future<String> getRefreshTokenExpiration();

  /// Delete refresh token expiration date
  Future<void> deleteRefreshTokenExpiration();

  /// Delete all authentication preferences
  Future deleteAll();

  @override
  String toString() => '$runtimeType{}';
}
