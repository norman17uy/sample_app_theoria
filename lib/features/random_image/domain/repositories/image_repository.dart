import 'package:dartz/dartz.dart';
import 'package:sample_app_theoria/core/error/failures.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';

abstract class ImageRepository {
  Future<Either<Failure, ImageModel>> getRandomImage();
}
