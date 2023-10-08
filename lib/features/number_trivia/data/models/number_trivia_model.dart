import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required num number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json["text"],
      number: json["number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "number": number,
      };

  @override
  String toString() {
    return "$text, $number, ";
  }
}
