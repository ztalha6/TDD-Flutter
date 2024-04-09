import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/core/usecase/usecase.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_number_trivia_test.mocks.dart';

void main() {
  MockNumberTriviaRepository mockedNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetRandomNumberTrivia usecase =
      GetRandomNumberTrivia(mockedNumberTriviaRepository);

  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get number from the repository',
    () async {
      //arange
      when(mockedNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));

      //act
      final result = await usecase(NoPrams());

      //assert
      expect(result, const Right(tNumberTrivia));
      verify(mockedNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockedNumberTriviaRepository);
    },
  );
}
