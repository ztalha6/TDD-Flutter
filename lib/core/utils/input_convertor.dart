import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnSignedNumber(String input) {
    try {
      final result = int.parse(input);
      if (result < 0) throw const FormatException();
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
