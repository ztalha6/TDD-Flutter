import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/core/utils/input_convertor.dart';

void main() {
  InputConverter inputConverter = InputConverter();

  group('String to Unsigned int', () {
    test(' - should return integer when str represents unsigned integer', () {
      const str = '123';

      final result = inputConverter.stringToUnSignedNumber(str);

      expect(result, const Right(123));
    });
    test(
        ' - should return InvalidInputFailure when str is not an integer or decimal',
        () {
      const str = 'abc';

      final result = inputConverter.stringToUnSignedNumber(str);

      expect(result, Left(InvalidInputFailure()));
    });
    test(' - should return InvalidInputFailure when str is empty', () {
      const str = '';

      final result = inputConverter.stringToUnSignedNumber(str);

      expect(result, Left(InvalidInputFailure()));
    });
    test(
        ' - should return InvalidInputFailure when str contains nagative number',
        () {
      const str = '-1';

      final result = inputConverter.stringToUnSignedNumber(str);

      expect(result, Left(InvalidInputFailure()));
    });
  });
}
