import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetTriviaForConcreteNumber>((event, emit) {
      // TODO: implement event handler
    });

    on<GetTriviaForRandomNumber>((event, emit) {
      // TODO: implement event handler
    });
  }
}
