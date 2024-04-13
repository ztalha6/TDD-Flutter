import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';

import 'package:tdd_flutter/features/number_trivia/data/data_sourses/number_trivia_local_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  MockSharedPreferences mockedSharedPreferences = MockSharedPreferences();
  NumberTriviaLocalDataSourceImp dataSource =
      NumberTriviaLocalDataSourceImp(mockedSharedPreferences);
  group(
    'getLastNumberTrivia',
    () {
      final tNummberTriviaModel =
          NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json')));

      test(
        'should return numberTrivia from SharedPreferences when there is one in the cached',
        () async {
          when(mockedSharedPreferences.getString(any))
              .thenReturn(fixture('trivia_cache.json'));

          final result = await dataSource.getLastNumberTrivia();

          verify(mockedSharedPreferences.getString(cachedTriviaKey));
          expect(result, equals(tNummberTriviaModel));
        },
      );
      test(
        'should throw cacheException when there is nota a cached value',
        () async {
          when(mockedSharedPreferences.getString(any)).thenReturn(null);

          final call = dataSource.getLastNumberTrivia;

          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group('cachedNumberTrivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'text trivia', number: 1);
    test('should call the sharedPrefs to cache the data', () {
      dataSource.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockedSharedPreferences.setString(
          cachedTriviaKey, expectedJsonString));
    });
  });
}
