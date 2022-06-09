import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_app_theoria/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  test(
    "Has Internet Conenction - should forward the call to DataConnectionChecker.hasConnection",
    () async {
      // arrange
      final tHasConnectionFuture = await Future.value(true);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFuture);
      // act
      final result = await networkInfoImpl.isConnected;

      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    },
  );
}
