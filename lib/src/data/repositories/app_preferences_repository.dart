/// Interface for all application preferences repository
/// Mostly only one local app preferences repository is needed
abstract class AppPreferencesRepository {
  /// Set User id ([String])
  Future<void> setUserId(String userId);

  /// Get User id
  ///
  /// Must return the user id [String] or [null] otherwise
  Future<String> getUserId();

  /// Delete User id
  Future<void> deleteUserId();

  /// Set User email ([String])
  Future<void> setUserEmail(String userEmail);

  /// Get User email
  ///
  /// Must return the user email [String] or [null] otherwise
  Future<String> getUserEmail();

  /// Delete User email
  Future<void> deleteUserEmail();

  /// Get App Theme
  ///
  /// Must return the application theme [String] or [null] otherwise
  Future<String> getAppTheme();

  /// Set Application theme ([String])
  Future<void> setAppTheme(String theme);

  /// Delete Application theme
  Future<void> deleteAppTheme();

  /// Delete all application preferences
  Future deleteAll();

  @override
  String toString() => '$runtimeType{}';
}
