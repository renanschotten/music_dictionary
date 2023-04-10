abstract class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});
}

class GenericFailure extends Failure {
  GenericFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, super.code});
}
