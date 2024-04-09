import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../data_sourses/number_trivia_local_data_source.dart';
import '../data_sourses/number_trivia_remote_data_source.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int? number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number!));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser tiviaCall,
  ) async {
    if (!await networkInfo.isConnected) {
      try {
        final cacheData = await localDataSource.getLastNumberTrivia();
        return Right(cacheData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    try {
      final remoteData = await tiviaCall();
      localDataSource.cacheNumberTrivia(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
