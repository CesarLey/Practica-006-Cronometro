abstract class Failure {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}