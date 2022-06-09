import 'package:dartz/dartz.dart';
import 'package:sample_app_theoria/core/error/failures.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/domain/repositories/image_repository.dart';

class GetRandomImage {
  final ImageRepository repository;
  GetRandomImage({
    required this.repository,
  });

  Future<Either<Failure, ImageModel>> call() async {
    return await repository.getRandomImage();
  }
}
