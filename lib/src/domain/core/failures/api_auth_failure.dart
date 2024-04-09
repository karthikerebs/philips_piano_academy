class ApiAuthFailure implements Exception {
  ApiAuthFailure(this.error);
  final String? error;
}
