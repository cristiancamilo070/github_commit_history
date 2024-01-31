import 'package:dartz/dartz.dart';

abstract class BaseUseCases<T, Parameters> {
  Future<Either<Exception, T>> execute(Parameters params);
}

abstract class BaseUseCasesNoParams<T> {
  Future<Either<Exception, T>> execute();
}

abstract class BaseStreamUseCasesNoParams<T> {
  Stream<Either<Exception, T>> execute();
}

abstract class BaseStreamUseCase<T, Parameters> {
  Stream<Either<Exception, T>> execute(Parameters params);
}
