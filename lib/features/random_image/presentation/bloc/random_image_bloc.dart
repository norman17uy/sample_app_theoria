import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'random_image_event.dart';
part 'random_image_state.dart';

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  RandomImageBloc() : super(RandomImageInitial()) {
    on<RandomImageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
