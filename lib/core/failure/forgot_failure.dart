class ForgotPasswordFailure {
  final String error;
  final String? statusCode;

  ForgotPasswordFailure({
    required this.error,
    this.statusCode,
  });
}
