import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, required this.listOfImages});

  final List<String> listOfImages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: BlocProvider.of<HomeCubit>(context).pageController,
          itemCount: listOfImages.length,
          itemBuilder: (context, index) {
            return Image.network(
              listOfImages[index],
              fit: BoxFit.fill,
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
                controller: BlocProvider.of<HomeCubit>(context).pageController,
                count: listOfImages.length,
                effect: SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 10,
                    dotHeight: 10,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Theme.of(context).primaryColor)),
          ),
        )
      ],
    );
  }
}
