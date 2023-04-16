class Failure {
  final String? message;
  final String? code;

  Failure({this.message, this.code});

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

class GenericFailure extends Failure {
  GenericFailure({required super.message, super.code});

  @override
  bool operator ==(covariant GenericFailure other) {
    if (identical(this, other)) return true;

    return other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, super.code});

  @override
  bool operator ==(covariant NetworkFailure other) {
    if (identical(this, other)) return true;

    return other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}
