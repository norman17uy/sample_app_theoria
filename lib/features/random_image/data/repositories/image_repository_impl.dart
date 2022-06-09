import 'package:dartz/dartz.dart';
import 'package:sample_app_theoria/core/error/exception.dart';

import 'package:sample_app_theoria/core/error/failures.dart';
import 'package:sample_app_theoria/core/network/network_info.dart';
import 'package:sample_app_theoria/features/random_image/data/datasources/image_remote_data_source.dart';
import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ImageRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, ImageModel>> getRandomImage() async {
    final hasConnection = await networkInfo.isConnected;
    if (hasConnection) {
      try {
        final imageDetails = await remoteDataSource.getRandomImage();
        return Right(imageDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
