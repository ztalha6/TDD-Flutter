import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_number_trivia.dart';

import 'get_number_trivia_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
void main() {
  MockNumberTriviaRepository mockedNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetNumberTrivia usecase = GetNumberTrivia(mockedNumberTriviaRepository);

  const int tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: tNumber);

  test(
    'should get number trivia from the repository',
    () async {
      //arange
      when(mockedNumberTriviaRepository.getNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));

      //act
      final result = await usecase(Params(tNumber));

      //assert
      expect(result, const Right(tNumberTrivia));
      verify(mockedNumberTriviaRepository.getNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockedNumberTriviaRepository);
    },
  );
}
