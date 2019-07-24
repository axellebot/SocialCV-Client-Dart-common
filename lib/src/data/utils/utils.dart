import 'package:social_cv_client_dart_common/presentation.dart';

DateTime generateExpirationDateTime(Duration duration) {
  return DateTime.now().add(duration);
}

Cursor checkCursor(Cursor cursor) {
  return cursor ??= Cursor();
}
