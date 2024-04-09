import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  MockInternetConnectionChecker mockInternetConnectionChecker =
      MockInternetConnectionChecker();
  NetworkInfoImp networkInfoImp = NetworkInfoImp(mockInternetConnectionChecker);

  group(
    'isConnected',
    () {
      test(
        'should forward the call to iternetConnectionChecker.hasConnection',
        () async {
          final tHasConnectionFuture = Future.value(false);

          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => tHasConnectionFuture);

          final result = networkInfoImp.isConnected;

          expect(result, tHasConnectionFuture);
        },
      );
    },
  );
}
