import 'package:flutter/material.dart';
import 'projects/projects_page.dart';
import 'games/games_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C5CE7),
      brightness: Brightness.dark,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'julsmzr',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF0F0F17),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.5,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            letterSpacing: 0.4,
            color: Color(0xFFCDD5E1),
          ),
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondaryContainer.withOpacity(.15),
            foregroundColor: colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 0,
          ),
        ),
      ),
      routes: {
        '/': (_) => const _LandingPage(),
        ProjectsPage.route: (_) => const ProjectsPage(),
        GamesPage.route: (_) => const GamesPage(),
      },
    );
  }
}

class _LandingPage extends StatelessWidget {
  const _LandingPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Futuristic gradient backdrop
          const _AnimatedBackground(),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) => const LinearGradient(
                        colors: [Color(0xFF7F5AF0), Color(0xFF2CB67D)],
                      ).createShader(rect),
                      child: Text('julsmzr', style: theme.textTheme.displayLarge?.copyWith(color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Building things • Exploring ideas • Shipping playful experiments',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 24,
                      runSpacing: 16,
                      children: const [
                        _NavButton(label: 'Projects', route: ProjectsPage.route, icon: Icons.auto_awesome),
                        _NavButton(label: 'Games', route: GamesPage.route, icon: Icons.videogame_asset_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '© 2025 julsmzr',
                style: TextStyle(fontSize: 12, color: Color(0xFF566074)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final String route;
  final IconData icon;
  const _NavButton({required this.label, required this.route, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 22),
      label: Text(label, style: const TextStyle(fontSize: 16, letterSpacing: 0.5)),
      onPressed: () => Navigator.of(context).pushNamed(route),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(.3), width: 1),
      ),
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();
  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _GridPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _GridPainter extends CustomPainter {
  final double progress;
  _GridPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = const Color(0xFF1B2230)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, p);

    final Paint line = Paint()
      ..color = const Color(0xFF273548)
      ..strokeWidth = 1;

    const spacing = 48.0;
    final shift = progress * spacing;

    for (double x = -shift; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height * .2, size.height), line);
    }
    for (double y = -shift; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }

    // subtle vignette overlay
    final vignette = RadialGradient(
      colors: [Colors.transparent, Colors.black.withOpacity(.55)],
      stops: const [0.6, 1.0],
    ).createShader(Offset.zero & size);
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = vignette
        ..blendMode = BlendMode.darken,
    );
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.progress != progress;
}
