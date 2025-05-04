abstract class Failure {
  final String message;
  Failure([this.message = ""]);
}

class ServerFailure extends Failure {
  ServerFailure({String message = "Server error"}) : super(message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure() : super("No internet connection");
}
