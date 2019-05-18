class BaseError extends Error {
  BaseError(this.message);

  String message;

  @override
  String toString() {
    return '$message';
  }
}
