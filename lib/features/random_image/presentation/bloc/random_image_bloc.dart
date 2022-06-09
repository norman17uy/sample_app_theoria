import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sample_app_theoria/features/random_image/data/models/image_model.dart';
import 'package:sample_app_theoria/features/random_image/domain/usecases/get_random_image.dart';

part 'random_image_event.dart';
part 'random_image_state.dart';

const String unknownError = 'Unknown error occured. Please try again.';

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  final GetRandomImage getRandomImage;
  RandomImageBloc(
    this.getRandomImage,
  ) : super(RandomImageInitial()) {
    on<FetchRandomImage>(_onGetRandomImage);
  }

  void _onGetRandomImage(
    FetchRandomImage event,
    Emitter<RandomImageState> emit,
  ) async {
    emit(RandomImageLoading());

    final failureOrImageDetails = await getRandomImage();
    failureOrImageDetails.fold(
      (l) => emit(
        const RandomImageLoadedError(message: unknownError),
      ),
      (imageDetails) => emit(
        RandomImageLoaded(imageModel: imageDetails),
      ),
    );
  }
}
