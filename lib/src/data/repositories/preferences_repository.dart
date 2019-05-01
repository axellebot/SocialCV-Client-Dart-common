import 'dart:async';

/// Interface for Preferences
abstract class PreferencesRepository {
  /// ----------------------------------------------------------
  /// ------------------------- Tokens -------------------------
  /// ----------------------------------------------------------

  Future<String> getAccessToken();

  Future<bool> setAccessToken(String accessToken);

  Future<bool> deleteAccessToken();

  Future<int> getAccessTokenExpiration();

  Future<bool> setAccessTokenExpiration(int accessTokenExpiration);

  Future<bool> deleteAccessTokenExpiration();

  Future<String> getRefreshToken();

  Future<bool> setRefreshToken(String refreshToken);

  Future<bool> deleteRefreshToken();

  Future<String> getRefreshTokenExpiration();

  Future<bool> setRefreshTokenExpiration(int refreshTokenExpiration);

  Future<bool> deleteRefreshTokenExpiration();

  /// ----------------------------------------------------------
  /// ---------------------- Account ---------------------------
  /// ----------------------------------------------------------

  Future<bool> setUserId(String userId);

  Future<String> getUserId();

  Future<bool> deleteUserId();

  /// ----------------------------------------------------------
  /// -------------------------- App ---------------------------
  /// ----------------------------------------------------------

  Future<String> getAppTheme();

  Future<bool> setAppTheme(String theme);

  Future<bool> deleteAppTheme();

  /// ----------------------------------------------------------
  /// -------------------------- All ---------------------------
  /// ----------------------------------------------------------

  Future deleteAll();
}
