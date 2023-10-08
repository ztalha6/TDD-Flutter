import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const numberTriviaModel = NumberTriviaModel(text: "Test", number: 1);
  const numberTriviaModelDouble = NumberTriviaModel(text: "Test", number: 1.20);

  test(
    'should be a subclass of number trivia entity',
    () async {
      expect(numberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('from json', () {
    test(
      'should return a model when json number is integer',
      () {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));

        //act
        final result = NumberTriviaModel.fromJson(jsonMap);

        //assert
        expect(result, numberTriviaModel);
      },
    );
    test(
      'should return a model when json number is double',
      () {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));

        //act
        final result = NumberTriviaModel.fromJson(jsonMap);

        //assert
        expect(result, numberTriviaModelDouble);
      },
    );
  });

  group('to json', () {
    test(
      'should return json map that contains proper data',
      () {
        final result = numberTriviaModel.toJson();

        final expectedMap = {
          "number": 1,
          "text": 'Test',
        };

        expect(result, expectedMap);
      },
    );
  });
}
