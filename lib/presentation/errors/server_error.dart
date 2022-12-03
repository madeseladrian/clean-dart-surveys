class ServerError implements Exception {
  final String? error;

  ServerError({required this.error});
}