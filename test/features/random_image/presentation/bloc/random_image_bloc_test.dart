import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_app_theoria/core/error/failures.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/domain/usecases/get_random_image.dart';
import 'package:sample_app_theoria/features/random_image/presentation/bloc/random_image_bloc.dart';

import 'random_image_bloc_test.mocks.dart';

@GenerateMocks([GetRandomImage])
void main() {
  late RandomImageBloc bloc;
  late MockGetRandomImage mockGetRandomImage;
  setUp(() {
    mockGetRandomImage = MockGetRandomImage();
    bloc = RandomImageBloc(mockGetRandomImage);
  });

  const tImageModel = ImageModel(
    url: "https://cdn.catboys.com/images/image_78.jpg",
    artist: "unknown",
    artistUrl: "none",
    sourceUrl: "none",
    error: "none",
  );
  blocTest(
    "should emit [Loading, Loaded] when data is gotten successfully",
    build: () => bloc,
    act: (RandomImageBloc bloc) {
      // arrange
      when(mockGetRandomImage.call())
          .thenAnswer((_) async => const Right(tImageModel));
      // act
      bloc.add(FetchRandomImage());
    },
    expect: () => [
      RandomImageLoading(),
      const RandomImageLoaded(imageModel: tImageModel),
    ],
  );

  blocTest(
    "should emit [Loading, RandomImageLoadedError] when data is gotten successfully",
    build: () => bloc,
    act: (RandomImageBloc bloc) {
      // arrange
      when(mockGetRandomImage.call())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      bloc.add(FetchRandomImage());
    },
    expect: () => [
      RandomImageLoading(),
      const RandomImageLoadedError(message: unknownError)
    ],
  );
}
