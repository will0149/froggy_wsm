import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/themes/colors/colors.dart';

import '../../domain/models/slider_model.dart';
import '../pages/auth/auth_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22

class Slideshow extends ConsumerWidget {
  final List<Widget> slides;

  const Slideshow({super.key, required this.slides});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return // 1. Add a Consumer
        Consumer(
      // 2. specify the builder and obtain a WidgetRef
      builder: (_, WidgetRef ref, __) {
        // 3. use ref.watch() to get the value of the provider
        final value = ref.watch(sliderModelProvider);
        return Center(
          child: Column(
            children: [
              Expanded(
                child: _Slides(
                  slides: slides,
                ),
              ),
              _Dots(
                totalSlides: slides.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots({super.key, required this.totalSlides});

  @override
  Widget build(BuildContext context) {
    var groupDots = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSlides, (index) => _Dot(index: index)),
    );
    List<Widget> list = [
      // const Text("Empezar"),
      groupDots,
      // MaterialButton(
      //   onPressed: () {},
      //   child: Text(
      //     "Empezar",
      //     style:
      //         Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
      //   ),
      //   color: parkeaBlueAccent,
      // )
    ];
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () => context.goNamed(AuthPage.routeName),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text(
                "Empezar",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Dot extends ConsumerWidget {
  final int index;

  const _Dot({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageViewIndex = ref.watch(sliderModelProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
            ? parkeaOrange
            : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends ConsumerStatefulWidget {
  final List<Widget> slides;

  const _Slides({super.key, required this.slides});

  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends ConsumerState<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      ref
          .read(sliderModelProvider.notifier)
          .setCurrentPage(pageViewController.page!);
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPageValue = ref.watch(sliderModelProvider);
    return PageView(
      controller: pageViewController,
      children: widget.slides
          .map((slide) => Transform(
                transform: Matrix4.identity()
                  ..rotateX(currentPageValue -
                      (widget.slides
                          .indexWhere((element) => element == slide))),
                child: _Slide(slide: slide),
              ))
          .toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Center(child: slide),
    );
  }
}
