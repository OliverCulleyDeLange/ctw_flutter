class HintException implements Exception {
  final String message;

  const HintException(
    this.message,
  );

  String toString() {
    return 'HintException: $message';
  }
}
