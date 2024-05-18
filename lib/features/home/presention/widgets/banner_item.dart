import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerItem extends StatelessWidget {
   BannerItem({super.key, required this.listOfImages,this.alignment=Alignment.bottomCenter});

  final List<String> listOfImages;
  final PageController pageController = PageController();
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: listOfImages.length,
          itemBuilder: (context, index) {
            return Image.network(
              listOfImages[index],
              fit: BoxFit.fill,
            );
          },
        ),
        Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
                controller: pageController,
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
