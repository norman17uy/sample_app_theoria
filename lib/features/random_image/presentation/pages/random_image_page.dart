import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sample_app_theoria/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:sample_app_theoria/features/random_image/presentation/widgets/widgets.dart';
import '../../../../injection_container.dart';

class RandomImagePage extends StatelessWidget {
  const RandomImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Random Image Viewer"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (_) => sl<RandomImageBloc>(),
      child: ScrollableContent(
        children: [
          BlocConsumer<RandomImageBloc, RandomImageState>(
            listener: (context, state) async {
              if (state is RandomImageLoading) {
                await EasyLoading.show(
                  status: 'fetching...',
                  maskType: EasyLoadingMaskType.black,
                );
              }
              {
                await EasyLoading.dismiss();
              }
            },
            builder: (context, state) {
              if (state is RandomImageLoaded) {
                return ImageDetailsContainer(imageModel: state.imageModel);
              } else if (state is RandomImageLoadedError) {
                return MessageDisplay(message: state.message);
              } else {
                return const SizedBox();
              }
            },
          ),
          BlocBuilder<RandomImageBloc, RandomImageState>(
            builder: (context, state) {
              if (state is RandomImageLoading) {
                return const SizedBox();
              } else {
                return CustomButton(
                  buttonLabel: "Fetch Image",
                  onButtonPressed: () {
                    context.read<RandomImageBloc>().add(FetchRandomImage());
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
