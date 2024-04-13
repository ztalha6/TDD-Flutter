import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<bool> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const String cachedTriviaKey = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImp implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImp(this.sharedPreferences);

  @override
  Future<bool> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    return await sharedPreferences.setString(
        cachedTriviaKey, json.encode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedTriviaKey);
    if (jsonString == null) {
      throw CacheException();
    }
    return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
  }
}
