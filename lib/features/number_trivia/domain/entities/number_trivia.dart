import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  const NumberTrivia({
    required this.text,
    required this.number,
  });

  final String? text;
  final num? number;

  @override
  String toString() {
    return "$text, $number, ";
  }

  @override
  List<Object?> get props => [
        text,
        number,
      ];
}
