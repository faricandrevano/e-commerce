import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final banners = [
    Image.asset('assets/images/banner1.png'),
    Image.asset('assets/images/banner2.png'),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 150,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: banner,
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: banners.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 5,
                dotColor: Color(0xFFFAFAFA),
                activeDotColor: blueColor,
                paintStyle: PaintingStyle.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
