import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/page_indicator_dots.dart';
import '../state/home_models.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key, required this.banners});

  final List<PromoBannerModel> banners;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  final PageController _controller = PageController();
  int _activePage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      children: [
        SizedBox(
          height: responsive.size(120),
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (index) => setState(() => _activePage = index),
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return Container(
                margin: responsive.padding(horizontal: 4),
                padding: responsive.padding(all: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(responsive.radius(18)),
                  gradient: LinearGradient(
                    colors: banner.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      banner.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.fontSize(16),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: responsive.spacing(6)),
                    Text(
                      banner.subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: responsive.fontSize(12),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: responsive.spacing(10)),
        PageIndicatorDots(count: widget.banners.length, activeIndex: _activePage),
      ],
    );
  }
}
