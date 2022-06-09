import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/domain/repositories/image_repository.dart';
import 'package:sample_app_theoria/features/random_image/domain/usecases/get_random_image.dart';

import 'get_random_image_test.mocks.dart';

@GenerateMocks([ImageRepository])
void main() {
  late GetRandomImage usecase;
  late MockImageRepository mockImageRepository;

  setUp(() {
    mockImageRepository = MockImageRepository();
    usecase = GetRandomImage(repository: mockImageRepository);
  });
  const tImageModel = ImageModel(
    url: "https://cdn.catboys.com/images/image_78.jpg",
    artist: "unknown",
    artistUrl: "none",
    sourceUrl: "none",
    error: "none",
  );

  test(
    "should get image details from repository",
    () async {
      // arrange
      when(mockImageRepository.getRandomImage())
          .thenAnswer((_) async => const Right(tImageModel));
      // act
      final result = await usecase();
      // assert
      expect(result, const Right(tImageModel));
      verify(mockImageRepository.getRandomImage());
    },
  );
}
