class ServerError implements Exception {
  final String error;

  ServerError(this.error);
}