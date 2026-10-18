import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../device/utils/is_first_run.dart';
import '../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../generated/l10n.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/11/22

/// Bienvenida de la primera ejecución: tres pasos con lo que hace la app y,
/// en el último, crear cuenta o iniciar sesión. Solo se marca como vista al
/// elegir una de las dos (ver [IsFirstRun.complete]).
class WelcomeSlidePage extends ConsumerStatefulWidget {
  const WelcomeSlidePage({super.key});
  static String get routeName => 'welcome';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<WelcomeSlidePage> createState() => _WelcomeSlidePageState();
}

class _WelcomeSlidePageState extends ConsumerState<WelcomeSlidePage> {
  static const _discoverAnimation = 'assets/lotties/89301-party-animals.json';
  static const _enrollAnimation = 'assets/lotties/29774-dance-party.json';
  static const _slideCount = 3;

  final _controller = PageController();
  int _page = 0;
  bool _leaving = false;

  bool get _isLast => _page == _slideCount - 1;

  @override
  void initState() {
    super.initState();
    // Se cargan antes de llegar a su paso: si no, el siguiente se ve vacío
    // mientras se lee el JSON. Lottie las guarda en su caché.
    for (final path in [_discoverAnimation, _enrollAnimation]) {
      AssetLottie(path).load();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) => _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );

  /// Marca la bienvenida como vista y recarga la sesión antes de navegar:
  /// con el estado aún en primera ejecución el router la devolvería aquí.
  Future<void> _finish(String routeName) async {
    if (_leaving) return;
    setState(() => _leaving = true);
    await IsFirstRun().complete();
    ref.invalidate(restAuthUCProvider);
    try {
      await ref.read(restAuthUCProvider.future);
    } on Object {
      // El router decide con el error; aquí solo se navega.
    }
    if (mounted) context.goNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final slides = [
      _WelcomeSlide(
        title: s.slideDiscoverTitle,
        text: s.slideDiscoverText,
        illustration: _SlideAnimation(_discoverAnimation, active: _page == 0),
      ),
      _WelcomeSlide(
        title: s.slideEnrollTitle,
        text: s.slideEnrollText,
        illustration: _SlideAnimation(_enrollAnimation, active: _page == 1),
      ),
      _WelcomeSlide(
        title: s.slideCreateTitle,
        text: s.slideCreateText,
        illustration: _CreateEventIllustration(active: _page == 2),
      ),
    ];
    assert(slides.length == _slideCount);

    return SafeScaffold(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            // Ocupa su lugar aunque no se vea, para que nada salte.
            child: Visibility(
              visible: !_isLast,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: TextButton(
                onPressed: () => _goTo(_slideCount - 1),
                child: Text(s.welcomeSkip),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (page) => setState(() => _page = page),
              children: slides,
            ),
          ),
          _PageDots(count: _slideCount, current: _page),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              // Solo entra el nuevo: los textos de los dos no se enciman.
              layoutBuilder: (current, _) => current!,
              child: _isLast
                  ? Column(
                      key: const ValueKey('finish'),
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _WelcomeButton(
                          label: s.welcomeSignUp,
                          onPressed: _leaving
                              ? null
                              : () => _finish(SignUpPage.routeName),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _leaving
                              ? null
                              : () => _finish(LoginPage.routeName),
                          child: Text(s.welcomeSignIn),
                        ),
                      ],
                    )
                  : Column(
                      key: const ValueKey('next'),
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _WelcomeButton(
                          label: s.welcomeNext,
                          onPressed: () => _goTo(_page + 1),
                        ),
                        // Mismo alto que con dos botones.
                        const SizedBox(height: 8),
                        Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: TextButton(
                            onPressed: null,
                            child: Text(s.welcomeSignIn),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _WelcomeButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      );
}

/// Un paso: nombre de la app, ilustración y texto. La ilustración se achica
/// si el texto crece (letra grande del sistema) en vez de recortarlo.
class _WelcomeSlide extends StatelessWidget {
  final String title;
  final String text;
  final Widget illustration;

  const _WelcomeSlide({
    required this.title,
    required this.text,
    required this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Parkea App',
            style:
                textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          Expanded(child: Center(child: illustration)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium
                ?.copyWith(color: parkeaOrange, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Animación de un paso: se reproduce desde el principio cada vez que el
/// paso queda visible.
class _SlideAnimation extends StatefulWidget {
  final String path;
  final bool active;

  const _SlideAnimation(this.path, {required this.active});

  @override
  State<_SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<_SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);

  @override
  void didUpdateWidget(_SlideAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active && _controller.duration != null) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Lottie.asset(
        widget.path,
        controller: _controller,
        fit: BoxFit.contain,
        onLoaded: (composition) {
          _controller.duration = composition.duration;
          if (widget.active) {
            _controller.forward(from: 0);
          } else {
            // Fuera de pantalla queda en su último cuadro, no vacía.
            _controller.value = 1;
          }
        },
      );
}

/// Ilustración de "crea tus eventos": la forma naranja de las otras
/// animaciones con una tarjeta de evento y el "+" de crear de la barra
/// inferior. Entra con un pequeño rebote al quedar visible.
class _CreateEventIllustration extends StatelessWidget {
  /// El coral del fondo de las animaciones (89301-party-animals).
  static const _blob = Color(0xFFFF703E);

  final bool active;

  const _CreateEventIllustration({required this.active});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1005 / 674,
      child: LayoutBuilder(builder: (context, constraints) {
        final w = constraints.maxWidth;
        return TweenAnimationBuilder<double>(
          // Cambiar la key reinicia la animación al volver al paso.
          key: ValueKey(active),
          tween: Tween(begin: active ? 0 : 1, end: 1),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutBack,
          builder: (context, t, child) => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: w * 0.95,
                height: w * 0.6,
                decoration: BoxDecoration(
                  color: _blob,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(w * 0.5, w * 0.35),
                    topRight: Radius.elliptical(w * 0.4, w * 0.25),
                    bottomLeft: Radius.elliptical(w * 0.35, w * 0.3),
                    bottomRight: Radius.elliptical(w * 0.5, w * 0.35),
                  ),
                ),
              ),
              for (final (right, top, size) in [
                (0.2, -0.09, 0.08),
                (0.1, -0.03, 0.045),
              ])
                Positioned(
                  right: w * right,
                  top: w * top,
                  child: Container(
                    width: w * size,
                    height: w * size,
                    decoration: const BoxDecoration(
                        color: _blob, shape: BoxShape.circle),
                  ),
                ),
              Transform.scale(
                scale: t,
                child: Transform.rotate(
                  angle: -0.06,
                  child: Container(
                    width: w * 0.5,
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.event,
                            size: w * 0.11, color: parkeaBlueAccent),
                        SizedBox(height: w * 0.03),
                        _Line(width: w * 0.32, color: scheme.onSurface),
                        SizedBox(height: w * 0.02),
                        _Line(
                          width: w * 0.22,
                          color: scheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: w * 0.18,
                bottom: w * 0.02,
                child: Transform.scale(
                  scale: t,
                  child: Container(
                    width: w * 0.16,
                    height: w * 0.16,
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: _blob, width: 4),
                    ),
                    child: Icon(Icons.add, size: w * 0.1, color: _blob),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Line extends StatelessWidget {
  final double width;
  final Color color;

  const _Line({required this.width, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      );
}

class _PageDots extends StatelessWidget {
  final int count;
  final int current;

  const _PageDots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: S.of(context).stepOfTotal(current + 1, count),
      child: ExcludeSemantics(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < count; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: i == current ? 24 : 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: i == current ? parkeaOrange : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
