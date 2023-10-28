import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/core/platform/network_info.dart';
import 'package:tdd_flutter/features/number_trivia/data/data_sourses/number_trivia_local_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/data_sourses/number_trivia_remote_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

class MockedLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([NumberTriviaRemoteDataSource])
void main() {
  MockNumberTriviaRemoteDataSource mockRemoteDataSource =
      MockNumberTriviaRemoteDataSource();
  MockedLocalDataSource mockLocalDataSource = MockedLocalDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();

  NumberTriviaRepositoryImpl repository = NumberTriviaRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  group('getConcreteNumberTrivia', () {
    const int tNumber = 1;
    const NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(
      text: 'test trivia ',
      number: tNumber,
    );
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if device is online', () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);
    });
  });
}
