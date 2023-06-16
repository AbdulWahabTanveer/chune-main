import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure(
      [String message = 'Something went wrong, check your connaction'])
      : super(message);
}
