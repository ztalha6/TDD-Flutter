import 'dart:convert';

import 'package:http/http.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {
  final Client client;

  NumberTriviaRemoteDataSourceImp({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      await _getTriviaFromUrl(url: 'http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      await _getTriviaFromUrl(url: 'http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl({required String url}) async {
    final Response response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
