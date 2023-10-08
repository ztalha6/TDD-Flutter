// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/error/failures.dart';
import 'package:tdd_flutter/core/usecase/usecase.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>?> call(Params params) async =>
      await numberTriviaRepository.getNumberTrivia(params.number);
}

class Params {
  final int number;

  Params(this.number);

  @override
  bool operator ==(covariant Params other) {
    if (identical(this, other)) return true;

    return other.number == number;
  }

  @override
  int get hashCode => number.hashCode;
}
