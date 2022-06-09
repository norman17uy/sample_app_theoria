import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_app_theoria/core/error/exception.dart';
import 'package:sample_app_theoria/core/error/failures.dart';
import 'package:sample_app_theoria/core/network/network_info.dart';
import 'package:sample_app_theoria/features/random_image/data/datasources/image_remote_data_source.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/data/repositories/image_repository_impl.dart';

import 'image_repository_impl_test.mocks.dart';

@GenerateMocks([
  ImageRemoteDataSource,
  NetworkInfo,
])
void main() {
  late MockImageRemoteDataSource mockImageRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ImageRepositoryImpl repositoryImpl;
  setUp(() {
    mockImageRemoteDataSource = MockImageRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ImageRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockImageRemoteDataSource,
    );
  });
  group("Has Internet connection", () {
    const tImageModel = ImageModel(
      url: "https://cdn.catboys.com/images/image_78.jpg",
      artist: "unknown",
      artistUrl: "none",
      sourceUrl: "none",
      error: "none",
    );
    test(
      "should return remote data when the call to remote data source is successful",
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockImageRemoteDataSource.getRandomImage())
            .thenAnswer((_) async => tImageModel);
        // act
        final result = await repositoryImpl.getRandomImage();
        // assert
        expect(result, const Right(tImageModel));
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      "should return server failure when the call to remote data source is unsuccessful",
      () async {
        //
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockImageRemoteDataSource.getRandomImage())
            .thenThrow(ServerException());
        // act
        final result = await repositoryImpl.getRandomImage();
        // assert
        verify(mockImageRemoteDataSource.getRandomImage());

        expect(result, Left(ServerFailure()));
      },
    );
  });
}
