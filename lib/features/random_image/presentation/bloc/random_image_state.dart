part of 'random_image_bloc.dart';

abstract class RandomImageState extends Equatable {
  const RandomImageState();

  @override
  List<Object> get props => [];
}

class RandomImageInitial extends RandomImageState {}

class RandomImageLoading extends RandomImageState {}

class RandomImageLoaded extends RandomImageState {
  final ImageModel imageModel;
  const RandomImageLoaded({
    required this.imageModel,
  });
  @override
  List<Object> get props => [];
}

class RandomImageLoadedError extends RandomImageState {
  final String message;
  const RandomImageLoadedError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
