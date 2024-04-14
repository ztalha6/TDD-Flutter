part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

final class NumberTriviaInitial extends NumberTriviaState {}

final class Loading extends NumberTriviaState {}

final class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const Loaded({required this.numberTrivia}) : super();
}

final class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message}) : super();
}
