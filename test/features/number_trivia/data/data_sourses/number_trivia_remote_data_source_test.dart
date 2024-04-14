import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/features/number_trivia/data/data_sourses/number_trivia_remote_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  MockClient mockClient = MockClient();
  NumberTriviaRemoteDataSourceImp dataSource =
      NumberTriviaRemoteDataSourceImp(client: mockClient);

  void mockHttpClient200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void mockHttpClient404() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong!', 404));
  }

  group('getConcreteNumberTrivia', () {
    const int tNumber = 1;
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform the GET request with number 
        being endpoint and with application/json header''', () {
      mockHttpClient200();

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(
        mockClient.get(Uri.parse('http://numbersapi.com/$tNumber'), headers: {
          'Content-Type': 'application/json',
        }),
      );
    });

    test('should return NumberTriviaModel when response code is 200', () async {
      mockHttpClient200();

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      verify(
        mockClient.get(Uri.parse('http://numbersapi.com/$tNumber'), headers: {
          'Content-Type': 'application/json',
        }),
      );
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return ServerException when response code is 404 or other',
        () async {
      mockHttpClient404();

      final call = dataSource.getConcreteNumberTrivia;

      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform the GET request 
        being endpoint and with application/json header''', () {
      mockHttpClient200();

      dataSource.getRandomNumberTrivia();

      verify(
        mockClient.get(Uri.parse('http://numbersapi.com/random'), headers: {
          'Content-Type': 'application/json',
        }),
      );
    });

    test('should return NumberTriviaModel when response code is 200', () async {
      mockHttpClient200();

      final result = await dataSource.getRandomNumberTrivia();

      verify(
        mockClient.get(Uri.parse('http://numbersapi.com/random'), headers: {
          'Content-Type': 'application/json',
        }),
      );
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return ServerException when response code is 404 or other',
        () async {
      mockHttpClient404();

      final call = dataSource.getRandomNumberTrivia;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
