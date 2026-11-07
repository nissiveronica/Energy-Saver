import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.database;
  runApp(const EnergySaverApp());
}

// ============================================================
// APP
// ============================================================

class EnergySaverApp extends StatelessWidget {
  const EnergySaverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Energy Saver',
      builder: (context, child) =>
          MarbleBackdrop(child: child ?? const SizedBox.shrink()),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD166),
          brightness: Brightness.dark,
          primary: const Color(0xFFFFD166),
          secondary: const Color(0xFFF4B942),
          tertiary: const Color(0xFFFFF2A6),
          surface: const Color(0xFF211A12),
          onSurface: const Color(0xFFFFF8E7),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: GoogleFonts.cinzelTextTheme(ThemeData.dark().textTheme)
            .apply(
              bodyColor: const Color(0xFFFFF8E7),
              displayColor: const Color(0xFFFFF8E7),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Color(0xFFFFF8E7),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFF8E7),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF1A1510),
          surfaceTintColor: Colors.transparent,
          elevation: 8,
          shadowColor: Color(0x66FFD166),
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            side: BorderSide(color: Color(0x66FFD166)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF211A12),
          labelStyle: TextStyle(color: Color(0xFFE2C98A)),
          prefixIconColor: Color(0xFFFFD166),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0x668E6D32)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0x668E6D32)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFFFD166), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD166),
            foregroundColor: const Color(0xFF211A12),
            elevation: 8,
            shadowColor: const Color(0x99FFD166),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFF211A12),
          indicatorColor: Color(0xFFFFD166),
          elevation: 12,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Color(0xFFFFF8E7), fontWeight: FontWeight.w700),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF3A2B18),
          contentTextStyle: TextStyle(color: Color(0xFFFFF8E7)),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

const heroImageUrl =
    'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=1400&q=85';
const homeImageUrl =
    'https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?w=1200&q=85';
const portfolioHeroImageUrl =
    'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=1400&q=85';
const portfolioDeviceImageUrl =
    'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=800&q=85';
const portfolioStatsImageUrl =
    'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&q=85';
const dashboardImageUrl =
    'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=1200&q=85';
const statisticsImageUrl =
    'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=1200&q=85';
const achievementsImageUrl =
    'https://images.unsplash.com/photo-1531058020387-3be344556be6?w=1200&q=85';
const profileImageUrl =
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&q=85';

const welcomeBackground = Colors.transparent;
const portfolioBackground = Colors.transparent;
const loginBackground = Colors.transparent;
const registerBackground = Colors.transparent;
const dashboardBackground = Colors.transparent;
const remindersBackground = Colors.transparent;
const devicesBackground = Colors.transparent;
const statisticsBackground = Colors.transparent;
const achievementsBackground = Colors.transparent;
const profileBackground = Colors.transparent;

const neonSurface = Color(0xFF1A1510);
const neonText = Color(0xFFFFF8E7);
const neonMutedText = Color(0xFFE2C98A);
const neonCyan = Color(0xFFFFD166);
const neonPink = Color(0xFFF4B942);
const neonGold = Color(0xFFFFF2A6);

class MarbleBackdrop extends StatelessWidget {
  final Widget child;

  const MarbleBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: MarblePainter(), child: child);
  }
}

class MarblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0D0A07),
    );

    final glowPaint = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0x443A2912), Color(0x000D0A07)])
              .createShader(
                Rect.fromCircle(
                  center: Offset(size.width * .72, size.height * .18),
                  radius: size.width * .8,
                ),
              );
    canvas.drawRect(Offset.zero & size, glowPaint);

    final veinPaint = Paint()
      ..color = const Color(0x26FFD166)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (var index = -2; index < 8; index++) {
      final path = Path();
      final startX = size.width * (index / 6.0);
      path.moveTo(startX, 0);
      for (var step = 0; step <= 12; step++) {
        final y = size.height * (step / 12);
        final x = startX + math.sin(step * 1.7 + index) * 34 + step * 9;
        path.lineTo(x, y);
      }
      canvas.drawPath(path, veinPaint);
    }

    final sparklePaint = Paint()..color = const Color(0x44FFF2A6);
    for (var index = 0; index < 70; index++) {
      final x = ((index * 83) % 997) / 997 * size.width;
      final y = ((index * 137) % 991) / 991 * size.height;
      final radius = index.isEven ? 1.1 : .6;
      canvas.drawCircle(Offset(x, y), radius, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(covariant MarblePainter oldDelegate) => false;
}

String reminderImageUrl(String title) {
  final text = title.toLowerCase();
  if (text.contains('light')) {
    return 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&q=80';
  }
  if (text.contains('fan')) {
    return 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=500&q=80';
  }
  if (text.contains('refrigerator') || text.contains('fridge')) {
    return 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=500&q=80';
  }
  if (text.contains('tv') || text.contains('television')) {
    return 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=500&q=80';
  }
  return 'https://images.unsplash.com/photo-1558008258-3256797b43f3?w=500&q=80';
}

String deviceImageUrl(String type) {
  final text = type.toLowerCase();
  if (text.contains('light')) {
    return 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=500&q=80';
  }
  if (text.contains('fan')) {
    return 'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=500&q=80';
  }
  if (text.contains('ac')) {
    return 'https://images.unsplash.com/photo-1631545806609-1f7c7a7f1c77?w=500&q=80';
  }
  if (text.contains('refrigerator') || text.contains('fridge')) {
    return 'https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=500&q=80';
  }
  if (text.contains('tv') || text.contains('television')) {
    return 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=500&q=80';
  }
  return 'https://images.unsplash.com/photo-1558008258-3256797b43f3?w=500&q=80';
}

// ============================================================
// MODELS
// ============================================================

class EnergyDevice {
  int? id;
  String name;
  String room;
  String type;
  double power;
  bool isOn;
  int minutesUsedToday;

  EnergyDevice({
    this.id,
    required this.name,
    required this.room,
    required this.type,
    required this.power,
    this.isOn = false,
    this.minutesUsedToday = 0,
  });

  factory EnergyDevice.fromMap(Map<String, dynamic> map) {
    return EnergyDevice(
      id: map['device_id'] as int?,
      name: map['device_name'] as String? ?? 'Device',
      room: map['room'] as String? ?? 'Unknown',
      type: map['device_type'] as String? ?? 'Device',
      power: (map['power_watts'] as num?)?.toDouble() ?? 0,
      isOn: (map['is_on'] as int? ?? 0) == 1,
      minutesUsedToday: map['minutes_used_today'] as int? ?? 0,
    );
  }
}

class EnergyReminder {
  int? id;
  String title;
  String time;
  bool isActive;
  bool completed;

  EnergyReminder({
    this.id,
    required this.title,
    required this.time,
    this.isActive = true,
    this.completed = false,
  });

  factory EnergyReminder.fromMap(Map<String, dynamic> map) {
    return EnergyReminder(
      id: map['reminder_id'] as int?,
      title: map['title'] as String? ?? 'Reminder',
      time: map['reminder_time'] as String? ?? 'Any time',
      isActive: (map['is_active'] as int? ?? 1) == 1,
      completed: (map['completed'] as int? ?? 0) == 1,
    );
  }
}

class Achievement {
  int? id;
  String title;
  String description;
  IconData icon;
  bool unlocked;

  Achievement({
    this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.unlocked = false,
  });

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['achievement_id'] as int?,
      title: map['achievement_name'] as String? ?? 'Achievement',
      description: map['description'] as String? ?? '',
      icon: achievementIcon(map['achievement_name'] as String? ?? ''),
      unlocked: (map['is_unlocked'] as int? ?? 0) == 1,
    );
  }
}

IconData achievementIcon(String title) {
  switch (title.toLowerCase()) {
    case 'first saver':
      return Icons.eco;
    case '5 kwh saver':
      return Icons.bolt;
    case 'device master':
      return Icons.power_settings_new;
    case '7-day saver':
      return Icons.local_fire_department;
    case 'eco champion':
      return Icons.emoji_events;
    default:
      return Icons.emoji_events;
  }
}

// ============================================================
// WELCOME PAGE
// ============================================================

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: welcomeBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 330,
                    width: double.infinity,
                    child: Image.network(
                      heroImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFF1264A3),
                        child: const Icon(
                          Icons.bolt,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: .72),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 24,
                    right: 24,
                    bottom: 28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ENERGY SAVER',
                          style: TextStyle(
                            color: Color(0xFFFFD166),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Live smarter.\nLeave a lighter footprint.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your home, at a glance',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: neonText,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Control devices, build better habits, and see the impact in real time.',
                        style: TextStyle(
                          color: neonMutedText,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _feature(
                            Icons.power_settings_new,
                            'Devices',
                            const Color(0xFF1264A3),
                          ),
                          _feature(
                            Icons.alarm,
                            'Reminders',
                            const Color(0xFFFF6B5F),
                          ),
                          _feature(
                            Icons.bar_chart,
                            'Live stats',
                            const Color(0xFF00A896),
                          ),
                          _feature(
                            Icons.emoji_events,
                            'Challenges',
                            const Color(0xFFF5A623),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PortfolioPage(),
                            ),
                          ),
                          icon: const Icon(Icons.login),
                          label: const Text(
                            'Explore the app',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PUBLIC PORTFOLIO
// ============================================================

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  void openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void openRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: portfolioBackground,
      appBar: AppBar(
        title: const Text(
          'Energy Saver',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => openLogin(context),
            icon: const Icon(Icons.login, size: 18),
            label: const Text('Login'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _portfolioHero(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 44),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeading(
                      'One calm place for a smarter home',
                      'Energy Saver turns everyday actions into visible progress. See what is running, build useful routines, and make every kilowatt count.',
                    ),
                    const SizedBox(height: 22),
                    _featureShowcase(
                      imageUrl: portfolioDeviceImageUrl,
                      eyebrow: 'CONTROL',
                      title: 'Your devices, clearly in view',
                      description: 'Bring the everyday machinery of your home into one visual command center, with room context and instant control close together.',
                      color: const Color(0xFF1264A3),
                      icon: Icons.power_settings_new,
                    ),
                    const SizedBox(height: 18),
                    _featureShowcase(
                      imageUrl: 'https://images.unsplash.com/photo-1524484485831-a92ffc0de03f?w=800&q=85',
                      eyebrow: 'BUILD HABITS',
                      title: 'Reminders that fit real life',
                      description: 'Shape a household rhythm around the moments when energy is usually forgotten. A gentle nudge becomes a repeatable ritual.',
                      color: const Color(0xFFFF6B5F),
                      icon: Icons.alarm,
                      reverse: true,
                    ),
                    const SizedBox(height: 18),
                    _featureShowcase(
                      imageUrl: portfolioStatsImageUrl,
                      eyebrow: 'UNDERSTAND IMPACT',
                      title: 'Progress you can feel',
                      description: 'Translate quiet household choices into a story of savings, climate impact, and momentum that gets more meaningful each day.',
                      color: const Color(0xFF00A896),
                      icon: Icons.insights,
                    ),
                    const SizedBox(height: 34),
                    _sectionHeading(
                      'Everything you need to stay consistent',
                      'Designed for the moments that matter: switching something off, checking a reminder, and seeing the result over time.',
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth > 620 ? 3 : 1;
                        return GridView.count(
                          crossAxisCount: columns,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: columns == 1 ? 3.2 : 1.0,
                          children: const [
                            _PortfolioTile(
                              Icons.notifications_active,
                              'Live reminders',
                              'Keep the next useful action close at hand.',
                              Color(0xFF33231B),
                              Color(0xFFFF6B5F),
                            ),
                            _PortfolioTile(
                              Icons.emoji_events,
                              'Energy challenges',
                              'Stay motivated with milestones and achievements.',
                              Color(0xFF302617),
                              Color(0xFFF5A623),
                            ),
                            _PortfolioTile(
                              Icons.lock_outline,
                              'Private by design',
                              'Your local account and energy data stay in your app.',
                              Color(0xFF18312C),
                              Color(0xFF00A896),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 34),
                    _impactBanner(context),
                  ],
                ),
              ),
            ),
            _portfolioFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _portfolioHero(BuildContext context) {
    return SizedBox(
      height: 430,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            portfolioHeroImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                Container(color: const Color(0xFF172B4D)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .08),
                  const Color(0xE6172B4D),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 34),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A BRIGHTER WAY TO LIVE',
                      style: TextStyle(
                        color: Color(0xFFFFD166),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Meet your\nenergy companion.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        height: 1.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A practical home energy app for better decisions, better habits, and a lighter footprint.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton.icon(
                      onPressed: () => openRegister(context),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Start saving today'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 27,
            height: 1.1,
            fontWeight: FontWeight.w800,
            color: neonGold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 15, height: 1.5, color: neonMutedText),
        ),
      ],
    );
  }

  Widget _featureShowcase({
    required String imageUrl,
    required String eyebrow,
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    bool reverse = false,
  }) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 190,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: color.withValues(alpha: .16),
            child: Icon(icon, size: 60, color: color),
          ),
        ),
      ),
    );
    final copy = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              eyebrow,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: neonText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: neonMutedText, height: 1.4),
            ),
          ],
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: neonSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: .4)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: .16), blurRadius: 18),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 560) {
            return Column(children: [image, const SizedBox(height: 12), copy]);
          }
          return Row(
            children: reverse
                ? [copy, const SizedBox(width: 20), Expanded(child: image)]
                : [Expanded(child: image), const SizedBox(width: 20), copy],
          );
        },
      ),
    );
  }

  Widget _impactBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1264A3), Color(0xFF00A896)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'READY TO SEE YOUR HOME DIFFERENTLY?',
            style: TextStyle(
              color: Color(0xFFFFD166),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start with one small switch.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your account and get a personal dashboard for your devices, reminders, and progress.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              ElevatedButton(
                onPressed: () => openRegister(context),
                child: const Text('Create account'),
              ),
              OutlinedButton(
                onPressed: () => openLogin(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                ),
                child: const Text('I already have an account'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _portfolioFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF172B4D),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        children: [
          const Icon(
            Icons.energy_savings_leaf,
            color: Color(0xFFFFD166),
            size: 34,
          ),
          const SizedBox(height: 8),
          const Text(
            'Energy Saver',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Make energy visible. Make change possible.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => openLogin(context),
            child: const Text(
              'Go to login',
              style: TextStyle(color: Color(0xFFFFD166)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color background;
  final Color color;

  const _PortfolioTile(
    this.icon,
    this.title,
    this.description,
    this.background,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: neonMutedText,
                    height: 1.3,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => loading = true);
    try {
      final user = await DatabaseHelper.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondaryAnimation) {
            return DashboardPage(
              userId: int.tryParse('${user['user_id']}') ?? 0,
              userName: user['name'] as String? ?? 'Energy Saver User',
              userEmail:
                  user['email'] as String? ?? emailController.text.trim(),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBackground,
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const Icon(Icons.lock_outline, size: 70, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) {
                    if (!loading) login();
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: 'Show password',
                      onPressed: () =>
                          setState(() => hidePassword = !hidePassword),
                      icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: loading ? null : login,
                    child: loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  child: const Text('Create a new account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REGISTER
// ============================================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirm = true;
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => loading = true);
    try {
      final userId = await DatabaseHelper.registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondaryAnimation) {
            return DashboardPage(
              userId: userId,
              userName: nameController.text.trim(),
              userEmail: emailController.text.trim(),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        final message = e.toString().toLowerCase().contains('unique')
            ? 'This email is already registered'
            : 'Registration failed: $e';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: registerBackground,
      appBar: AppBar(title: const Text('Create Account')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const Icon(Icons.person_add, size: 70, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => hidePassword = !hidePassword),
                      icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: confirmController,
                  obscureText: hideConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_reset),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => hideConfirm = !hideConfirm),
                      icon: Icon(
                        hideConfirm ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: loading ? null : register,
                    child: loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardPage extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;

  const DashboardPage({
    super.key,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget? _popup;

  void showAnimatedPopup({
    required String icon,
    required String title,
    required String message,
  }) {
    setState(() {
      _popup = AnimatedPopUp(
        icon: icon,
        title: title,
        message: message,
        onDone: () {
          if (mounted) setState(() => _popup = null);
        },
      );
    });
  }

  int selectedIndex = 0;
  bool notificationsEnabled = true;
  bool loading = true;
  late String currentUserName;
  final double electricityRate = 8.0;
  final double co2PerKwh = 0.7;
  final double dailyGoal = 3.0;
  double energySaved = 0.0;
  int challengeDays = 5;
  List<EnergyDevice> devices = [];
  List<EnergyReminder> reminders = [];
  List<Achievement> achievements = [];

  int get activeDevices => devices.where((d) => d.isOn).length;
  int get completedReminders => reminders.where((r) => r.completed).length;
  int get pendingReminders =>
      reminders.where((r) => r.isActive && !r.completed).length;
  double get estimatedMoneySaved => energySaved * electricityRate;
  double get co2Reduced => energySaved * co2PerKwh;
  double get goalProgress =>
      (energySaved / dailyGoal).clamp(0.0, 1.0).toDouble();

  int get energyScore {
    int score = 50;
    score += completedReminders * 8;
    score += activeDevices <= 2 ? 10 : 0;
    score += energySaved >= 2 ? 10 : 0;
    score += challengeDays >= 5 ? 10 : 0;
    return score > 100 ? 100 : score;
  }

  @override
  void initState() {
    super.initState();
    currentUserName = widget.userName;
    loadData();
  }

  Future<void> loadData() async {
    try {
      final deviceMaps = await DatabaseHelper.getDevices(widget.userId);
      final reminderMaps = await DatabaseHelper.getReminders(widget.userId);
      final achievementMaps = await DatabaseHelper.getAchievements(
        widget.userId,
      );
      final usageMaps = await DatabaseHelper.getEnergyUsage(widget.userId);

      devices = deviceMaps.map(EnergyDevice.fromMap).toList();
      reminders = reminderMaps.map(EnergyReminder.fromMap).toList();
      achievements = achievementMaps.map(Achievement.fromMap).toList();

      if (usageMaps.isNotEmpty) {
        final latest = usageMaps.last;
        energySaved = (latest['energy_saved_kwh'] as num?)?.toDouble() ?? 0.0;
      }

      if (devices.isEmpty) await seedDefaultDevices();
      if (reminders.isEmpty) await seedDefaultReminders();
      if (achievements.isEmpty) await seedDefaultAchievements();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Database loading error: $e')));
      }
    }

    if (mounted) setState(() => loading = false);
  }

  Future<void> seedDefaultDevices() async {
    final defaults = [
      ['Bedroom Light', 'Bedroom', 'Light', 12.0, 1, 180],
      ['Ceiling Fan', 'Bedroom', 'Fan', 55.0, 0, 120],
      ['Air Conditioner', 'Living Room', 'AC', 1200.0, 1, 60],
      ['Refrigerator', 'Kitchen', 'Refrigerator', 150.0, 1, 500],
      ['Study Room Light', 'Study Room', 'Light', 10.0, 0, 90],
    ];
    for (final d in defaults) {
      final id = await DatabaseHelper.addDevice(
        userId: widget.userId,
        name: d[0] as String,
        room: d[1] as String,
        type: d[2] as String,
        power: d[3] as double,
        isOn: (d[4] as int) == 1,
        minutesUsedToday: d[5] as int,
      );
      devices.add(
        EnergyDevice(
          id: id,
          name: d[0] as String,
          room: d[1] as String,
          type: d[2] as String,
          power: d[3] as double,
          isOn: (d[4] as int) == 1,
          minutesUsedToday: d[5] as int,
        ),
      );
    }
  }

  Future<void> seedDefaultReminders() async {
    final defaults = [
      ['Turn off bedroom lights', '10:00 PM', false],
      ['Switch off fan before sleeping', '11:00 PM', false],
      ['Check refrigerator door', '8:00 PM', true],
      ['Turn off TV after use', '9:30 PM', false],
    ];
    for (final r in defaults) {
      final id = await DatabaseHelper.addReminder(
        userId: widget.userId,
        title: r[0] as String,
        time: r[1] as String,
        isActive: true,
        completed: r[2] as bool,
      );
      reminders.add(
        EnergyReminder(
          id: id,
          title: r[0] as String,
          time: r[1] as String,
          completed: r[2] as bool,
        ),
      );
    }
  }

  Future<void> seedDefaultAchievements() async {
    final defaults = [
      ['First Saver', 'Save your first 1 kWh', true],
      ['5 kWh Saver', 'Save 5 kWh of energy', false],
      ['Device Master', 'Turn off 10 unnecessary devices', true],
      ['7-Day Saver', 'Complete a 7-day challenge', false],
      ['Eco Champion', 'Reach an energy score of 90', false],
    ];
    for (final a in defaults) {
      final id = await DatabaseHelper.addAchievement(
        userId: widget.userId,
        name: a[0] as String,
        description: a[1] as String,
        unlocked: a[2] as bool,
      );
      achievements.add(
        Achievement(
          id: id,
          title: a[0] as String,
          description: a[1] as String,
          icon: achievementIcon(a[0] as String),
          unlocked: a[2] as bool,
        ),
      );
    }
  }

  Future<void> saveEnergyUsage() async {
    await DatabaseHelper.addEnergyUsage(
      userId: widget.userId,
      date: DateTime.now().toIso8601String().split('T').first,
      energyUsed: 0.0,
      energySaved: energySaved,
      moneySaved: estimatedMoneySaved,
      co2Reduced: co2Reduced,
    );
  }

  Future<void> toggleDevice(int index, bool value) async {
    final device = devices[index];
    final newMinutes = value
        ? device.minutesUsedToday + 5
        : device.minutesUsedToday;
    await DatabaseHelper.updateDevice(
      deviceId: device.id!,
      isOn: value,
      minutesUsedToday: newMinutes,
    );
    if (!mounted) return;
    setState(() {
      device.isOn = value;
      device.minutesUsedToday = newMinutes;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 900),
        content: Text('${device.name} ${value ? 'turned ON' : 'turned OFF'}'),
      ),
    );

    if (!value) {
      showAnimatedPopup(
        icon: '⚡',
        title: 'Energy Saved!',
        message: 'Great job! You turned off an unnecessary device.',
      );
    } else {
      showAnimatedPopup(
        icon: '🔌',
        title: 'Device Turned On',
        message: 'Remember to switch it off when it is not needed.',
      );
    }
  }

  Future<void> toggleReminder(int index, bool value) async {
    final reminder = reminders[index];
    final wasCompleted = reminder.completed;
    await DatabaseHelper.updateReminder(
      reminderId: reminder.id!,
      isActive: reminder.isActive,
      completed: value,
    );
    if (!mounted) return;
    setState(() {
      reminder.completed = value;
      if (value && !wasCompleted) energySaved += 0.2;
      if (!value && wasCompleted) {
        energySaved = (energySaved - 0.2)
            .clamp(0.0, double.infinity)
            .toDouble();
      }
    });
    await saveEnergyUsage();
    await updateAchievements();

    if (value) {
      showAnimatedPopup(
        icon: '✅',
        title: 'Reminder Completed!',
        message: 'Nice work! You are one step closer to saving more energy.',
      );
    }

    if (mounted) setState(() {});
  }

  Future<void> addReminder(String title, String time) async {
    final id = await DatabaseHelper.addReminder(
      userId: widget.userId,
      title: title,
      time: time,
    );
    if (!mounted) return;
    setState(
      () => reminders.add(EnergyReminder(id: id, title: title, time: time)),
    );
  }

  Future<void> addDevice(
    String name,
    String room,
    String type,
    double power,
  ) async {
    final id = await DatabaseHelper.addDevice(
      userId: widget.userId,
      name: name,
      room: room,
      type: type,
      power: power,
    );
    if (!mounted) return;
    setState(
      () => devices.add(
        EnergyDevice(id: id, name: name, room: room, type: type, power: power),
      ),
    );
  }

  Future<void> updateAchievements() async {
    for (final achievement in achievements) {
      bool shouldUnlock = achievement.unlocked;
      if (achievement.title == 'First Saver' && energySaved >= 1) {
        shouldUnlock = true;
      }
      if (achievement.title == '5 kWh Saver' && energySaved >= 5) {
        shouldUnlock = true;
      }
      if (achievement.title == 'Device Master' &&
          devices.where((d) => !d.isOn).length >= 10) {
        shouldUnlock = true;
      }
      if (achievement.title == '7-Day Saver' && challengeDays >= 7) {
        shouldUnlock = true;
      }
      if (achievement.title == 'Eco Champion' && energyScore >= 90) {
        shouldUnlock = true;
      }
      if (shouldUnlock != achievement.unlocked) {
        await DatabaseHelper.updateAchievement(
          achievementId: achievement.id!,
          unlocked: shouldUnlock,
        );
        achievement.unlocked = shouldUnlock;

        if (shouldUnlock) {
          showAnimatedPopup(
            icon: '🏆',
            title: 'Achievement Unlocked!',
            message: achievement.title,
          );
        }
      }
    }
  }

  Future<bool> updateUserName(String newName) async {
    final cleanedName = newName.trim();
    if (cleanedName.isEmpty) return false;

    try {
      final db = await DatabaseHelper.database;
      await db.update(
        'users',
        {'name': cleanedName},
        where: 'user_id = ?',
        whereArgs: [widget.userId],
      );

      if (!mounted) return false;
      setState(() => currentUserName = cleanedName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username updated successfully')),
      );
      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update username: $e')),
        );
      }
      return false;
    }
  }

  void changePage(int index) {
    if (selectedIndex == index) return;

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: dashboardBackground,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      HomeDashboard(
        devices: devices,
        reminders: reminders,
        energySaved: energySaved,
        energyScore: energyScore,
        activeDevices: activeDevices,
        pendingReminders: pendingReminders,
        estimatedMoneySaved: estimatedMoneySaved,
        co2Reduced: co2Reduced,
        goalProgress: goalProgress,
        onPageChange: changePage,
        onDeviceToggle: toggleDevice,
        onReminderToggle: toggleReminder,
      ),
      RemindersPage(
        reminders: reminders,
        onToggle: toggleReminder,
        onAdd: addReminder,
      ),
      DevicesPage(devices: devices, onToggle: toggleDevice, onAdd: addDevice),
      StatisticsPage(
        devices: devices,
        energySaved: energySaved,
        moneySaved: estimatedMoneySaved,
        co2Reduced: co2Reduced,
        energyScore: energyScore,
      ),
      AchievementsPage(
        achievements: achievements,
        challengeDays: challengeDays,
        energyScore: energyScore,
      ),
      ProfilePage(
        userName: currentUserName,
        userEmail: widget.userEmail,
        notificationsEnabled: notificationsEnabled,
        onUserNameChanged: updateUserName,
        onNotificationChanged: (value) =>
            setState(() => notificationsEnabled = value),
        onLogout: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const WelcomePage()),
            (route) => false,
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: dashboardBackground,

      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 650),
            reverseDuration: const Duration(milliseconds: 450),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slide =
                  Tween<Offset>(
                    begin: const Offset(0.12, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

              final scale = Tween<double>(begin: 0.97, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              );

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slide,
                  child: ScaleTransition(scale: scale, child: child),
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(selectedIndex),
              child: pages[selectedIndex],
            ),
          ),
          if (_popup != null) Positioned.fill(child: _popup!),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: changePage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm_outlined),
            selectedIcon: Icon(Icons.alarm),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.devices_outlined),
            selectedIcon: Icon(Icons.devices),
            label: 'Devices',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Awards',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TIME-BASED GREETING
// ============================================================

class TimeGreeting extends StatefulWidget {
  const TimeGreeting({super.key});

  @override
  State<TimeGreeting> createState() => _TimeGreetingState();
}

class _TimeGreetingState extends State<TimeGreeting> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning 👋';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon ☀️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening 🌆';
    } else {
      return 'Good Night 🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final scale = Tween<double>(begin: 0.85, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        );
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
      child: Text(
        greeting,
        key: ValueKey(greeting),
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ============================================================
// ANIMATION HELPERS
// ============================================================

class AnimatedPopUp extends StatefulWidget {
  final String icon;
  final String title;
  final String message;
  final VoidCallback onDone;

  const AnimatedPopUp({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.onDone,
  });

  @override
  State<AnimatedPopUp> createState() => _AnimatedPopUpState();
}

class _AnimatedPopUpState extends State<AnimatedPopUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) widget.onDone();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 310,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF10251B),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 28,
                      spreadRadius: 3,
                      color: Colors.black38,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.icon, style: const TextStyle(fontSize: 48)),
                    const SizedBox(height: 10),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedActionCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedActionCard({super.key, required this.child, this.onTap});

  @override
  State<AnimatedActionCard> createState() => _AnimatedActionCardState();
}

class _AnimatedActionCardState extends State<AnimatedActionCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedScale(
        scale: pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class AnimatedNumber extends StatelessWidget {
  final double value;
  final String suffix;
  final int decimals;

  const AnimatedNumber({
    super.key,
    required this.value,
    this.suffix = '',
    this.decimals = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Text(
          '${animatedValue.toStringAsFixed(decimals)}$suffix',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}

class AnimatedScore extends StatelessWidget {
  final int score;

  const AnimatedScore({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: score.toDouble()),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: 118,
          height: 118,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 118,
                height: 118,
                child: CircularProgressIndicator(
                  value: (value / 100).clamp(0.0, 1.0),
                  strokeWidth: 10,
                  backgroundColor: Colors.white12,
                ),
              ),
              Text(
                '${value.round()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// HOME DASHBOARD
// ============================================================

class HomeDashboard extends StatelessWidget {
  final List<EnergyDevice> devices;
  final List<EnergyReminder> reminders;

  final double energySaved;
  final int energyScore;
  final int activeDevices;
  final int pendingReminders;
  final double estimatedMoneySaved;
  final double co2Reduced;
  final double goalProgress;

  final Function(int) onPageChange;
  final Function(int, bool) onDeviceToggle;
  final Function(int, bool) onReminderToggle;

  const HomeDashboard({
    super.key,
    required this.devices,
    required this.reminders,
    required this.energySaved,
    required this.energyScore,
    required this.activeDevices,
    required this.pendingReminders,
    required this.estimatedMoneySaved,
    required this.co2Reduced,
    required this.goalProgress,
    required this.onPageChange,
    required this.onDeviceToggle,
    required this.onReminderToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBackground,
      appBar: AppBar(
        title: const Text(
          'Energy Saver',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have new energy-saving suggestions'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TimeGreeting(),

            const SizedBox(height: 5),

            Text(
              'Your live household energy snapshot',
              style: TextStyle(color: neonMutedText, fontSize: 16),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 170,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      dashboardImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFF00A896),
                        child: const Icon(
                          Icons.home_work,
                          size: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(color: Colors.black.withValues(alpha: .32)),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REAL-TIME HOUSEHOLD VIEW',
                              style: TextStyle(
                                color: Color(0xFFFFD166),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.4,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Know what is running.\nAct at the right moment.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                                height: 1.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // ENERGY SCORE
            // =================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFF172B4D),
                    Color(0xFF1264A3),
                    Color(0xFF00A896),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 105,
                    height: 105,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 105,
                          height: 105,
                          child: CircularProgressIndicator(
                            value: energyScore / 100,
                            strokeWidth: 10,
                            backgroundColor: Colors.white24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$energyScore',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ENERGY SAVING SCORE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'You are on track!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Keep switching off devices when they are not needed.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // ENERGY SAVED
            // =================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: neonSurface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: neonCyan.withValues(alpha: .35)),
                boxShadow: [
                  BoxShadow(
                    color: neonCyan.withValues(alpha: .12),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Energy Saved Today',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: neonText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        energySaved.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A896),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('kWh', style: TextStyle(fontSize: 17)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: goalProgress,
                    minHeight: 9,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${(goalProgress * 100).toStringAsFixed(0)}% of your 3 kWh daily goal',
                    style: TextStyle(color: neonMutedText),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // MONEY + CO2
            // =================================================
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    Icons.currency_rupee,
                    'Money Saved',
                    '₹${estimatedMoneySaved.toStringAsFixed(2)}',
                    const Color(0xFFFF6B5F),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    Icons.eco,
                    'CO₂ Reduced',
                    '${co2Reduced.toStringAsFixed(2)} kg',
                    const Color(0xFF00A896),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // =================================================
            // QUICK CONTROL
            // =================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quick Device Control',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    onPageChange(2);
                  },
                  child: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...devices.take(4).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final device = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                color: device.isOn ? const Color(0xFF18312C) : neonSurface,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: device.isOn
                        ? const Color(0xFF18312C)
                        : const Color(0xFF2B261F),
                    child: Icon(
                      deviceIcon(device.type),
                      color: device.isOn ? Colors.green : Colors.grey,
                    ),
                  ),

                  title: Text(
                    device.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(
                    '${device.room} • ${device.power.toStringAsFixed(0)} W',
                  ),

                  // =================================================
                  // WORKING ACCESSIBLE SWITCH
                  // =================================================
                  trailing: Switch(
                    value: device.isOn,
                    onChanged: (value) {
                      onDeviceToggle(index, value);
                    },
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // =================================================
            // REMINDERS
            // =================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Energy Reminders',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    onPageChange(1);
                  },
                  child: const Text('View All'),
                ),
              ],
            ),

            ...reminders.take(3).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final reminder = entry.value;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                color: const Color(0xFF1A1510),
                surfaceTintColor: Colors.transparent,
                child: CheckboxListTile(
                  value: reminder.completed,
                  onChanged: (value) {
                    onReminderToggle(index, value ?? false);
                  },
                  secondary: Icon(
                    reminder.completed ? Icons.check_circle : Icons.alarm,
                    color: reminder.completed
                        ? const Color(0xFF00A896)
                        : const Color(0xFFFF6B5F),
                  ),
                  title: Text(
                    reminder.title,
                    style: TextStyle(
                      decoration: reminder.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(reminder.time),
                ),
              );
            }),

            const SizedBox(height: 20),

            // =================================================
            // SMART RECOMMENDATION
            // =================================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3A2B18), Color(0xFF2F211B)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x668E6D32)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: Color(0xFFFF6B5F),
                    size: 32,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Smart Recommendation',
                          style: TextStyle(
                            color: neonText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Your AC consumes the most power. Consider turning it off when the room is not occupied.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: .16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: neonMutedText)),
        ],
      ),
    );
  }
}

// ============================================================
// REMINDERS PAGE
// ============================================================

class LiveStatus extends StatefulWidget {
  const LiveStatus({super.key});

  @override
  State<LiveStatus> createState() => _LiveStatusState();
}

class _LiveStatusState extends State<LiveStatus> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now().format(context);
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: const BoxDecoration(
            color: Color(0xFF00A896),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'LIVE HOME MONITOR  •  $now',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1264A3),
          ),
        ),
      ],
    );
  }
}

class RemindersPage extends StatelessWidget {
  final List<EnergyReminder> reminders;

  final Function(int, bool) onToggle;
  final Function(String, String) onAdd;

  const RemindersPage({
    super.key,
    required this.reminders,
    required this.onToggle,
    required this.onAdd,
  });

  void addReminderDialog(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Energy Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Reminder',
                  hintText: 'Turn off TV',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: '10:00 PM',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  return;
                }

                onAdd(
                  titleController.text.trim(),
                  timeController.text.trim().isEmpty
                      ? 'Any time'
                      : timeController.text.trim(),
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = reminders
        .where((r) => r.isActive && !r.completed)
        .length;

    return Scaffold(
      backgroundColor: remindersBackground,
      appBar: AppBar(
        title: const Text(
          'Energy Reminders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF19352F), Color(0xFF3A2B18)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x668E6D32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LiveStatus(),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.alarm, color: Color(0xFFFF6B5F), size: 35),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Saving Reminders',
                            style: TextStyle(
                              color: neonText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$activeCount actions still waiting for you',
                            style: TextStyle(color: neonMutedText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return Card(
                  color: const Color(0xFF1A1510),
                  surfaceTintColor: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 12),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onToggle(index, !reminder.completed),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 94,
                          height: 112,
                          child: Image.network(
                            reminderImageUrl(reminder.title),
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFF33231B),
                              child: Icon(
                                reminder.completed ? Icons.check : Icons.alarm,
                                color: const Color(0xFFFF6B5F),
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reminder.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: reminder.completed
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 15,
                                      color: Color(0xFF1264A3),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(reminder.time),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  reminder.completed
                                      ? 'Completed today'
                                      : 'Tap to mark complete',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: reminder.completed
                                        ? const Color(0xFF00A896)
                                        : neonMutedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Checkbox(
                            value: reminder.completed,
                            onChanged: (value) =>
                                onToggle(index, value ?? false),
                            activeColor: const Color(0xFF00A896),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addReminderDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Reminder'),
      ),
    );
  }
}

// ============================================================
// DEVICES PAGE
// ============================================================

class DevicesPage extends StatelessWidget {
  final List<EnergyDevice> devices;

  final Function(int, bool) onToggle;
  final Function(String, String, String, double) onAdd;

  const DevicesPage({
    super.key,
    required this.devices,
    required this.onToggle,
    required this.onAdd,
  });

  void addDeviceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final roomController = TextEditingController();
    final typeController = TextEditingController();
    final powerController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Device'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Device Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: roomController,
                  decoration: const InputDecoration(
                    labelText: 'Room',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    hintText: 'Light / Fan / AC / TV',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: powerController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Power in Watts',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  return;
                }

                final power = double.tryParse(powerController.text) ?? 0;

                onAdd(
                  nameController.text.trim(),
                  roomController.text.trim().isEmpty
                      ? 'Unknown'
                      : roomController.text.trim(),
                  typeController.text.trim().isEmpty
                      ? 'Device'
                      : typeController.text.trim(),
                  power,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: devicesBackground,
      appBar: AppBar(
        title: const Text(
          'My Devices',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 14),
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF172B4D), Color(0xFF1264A3)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LiveStatus(),
                SizedBox(height: 12),
                Text(
                  'A clearer view of\nyour home load.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  clipBehavior: Clip.antiAlias,
                  surfaceTintColor: Colors.transparent,
                  color: device.isOn ? const Color(0xFF18312C) : neonSurface,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 180,
                        width: 128,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              deviceImageUrl(device.type),
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  Container(color: const Color(0xFF18312C)),
                            ),
                            Container(
                              color: Colors.black.withValues(alpha: .32),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  device.room.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 13, 10, 12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: device.isOn
                                    ? const Color(0xFFD9F5EF)
                                    : const Color(0xFF2B261F),
                                child: Icon(
                                  deviceIcon(device.type),
                                  size: 26,
                                  color: device.isOn
                                      ? const Color(0xFF00A896)
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      device.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${device.power.toStringAsFixed(0)} W  •  ${device.minutesUsedToday} min today',
                                      style: TextStyle(
                                        color: neonMutedText,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      device.isOn ? 'ACTIVE NOW' : 'STANDBY',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: device.isOn
                                            ? const Color(0xFF00A896)
                                            : Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Switch(
                                    value: device.isOn,
                                    onChanged: (value) =>
                                        onToggle(index, value),
                                    activeThumbColor: const Color(0xFF00A896),
                                  ),
                                  IconButton(
                                    tooltip: device.isOn
                                        ? 'Turn OFF'
                                        : 'Turn ON',
                                    onPressed: () =>
                                        onToggle(index, !device.isOn),
                                    icon: Icon(
                                      device.isOn
                                          ? Icons.power
                                          : Icons.power_off,
                                      color: device.isOn
                                          ? const Color(0xFF00A896)
                                          : const Color(0xFFFF6B5F),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addDeviceDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Device'),
      ),
    );
  }
}

// ============================================================
// STATISTICS
// ============================================================

class StatisticsPage extends StatelessWidget {
  final List<EnergyDevice> devices;
  final double energySaved;
  final double moneySaved;
  final double co2Reduced;
  final int energyScore;

  const StatisticsPage({
    super.key,
    required this.devices,
    required this.energySaved,
    required this.moneySaved,
    required this.co2Reduced,
    required this.energyScore,
  });

  double get currentPower {
    return devices
        .where((device) => device.isOn)
        .fold(0, (sum, device) => sum + device.power);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statisticsBackground,
      appBar: AppBar(
        title: const Text(
          'Energy Statistics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      statisticsImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: const Color(0xFF172B4D)),
                    ),
                    Container(color: const Color(0x99172B4D)),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'The numbers behind\nyour daily choices.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Household Consumption Overview',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Review the signals behind your energy habits.',
              style: TextStyle(color: neonMutedText),
            ),

            const SizedBox(height: 25),

            _bigStat(
              Icons.bolt,
              'Energy Saved',
              '${energySaved.toStringAsFixed(1)} kWh',
              Colors.green,
            ),

            _bigStat(
              Icons.currency_rupee,
              'Estimated Money Saved',
              '₹${moneySaved.toStringAsFixed(2)}',
              Colors.orange,
            ),

            _bigStat(
              Icons.eco,
              'CO₂ Reduction',
              '${co2Reduced.toStringAsFixed(2)} kg',
              Colors.teal,
            ),

            _bigStat(
              Icons.power,
              'Current Device Load',
              '${currentPower.toStringAsFixed(0)} W',
              Colors.blue,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1711),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x668E6D32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Energy Saving Score',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  LinearProgressIndicator(
                    value: energyScore / 100,
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '$energyScore / 100',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Seven-Day Activity Pattern',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Container(
              height: 280,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1711),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x668E6D32)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _bar('Mon', .40),
                  _bar('Tue', .65),
                  _bar('Wed', .35),
                  _bar('Thu', .80),
                  _bar('Fri', .55),
                  _bar('Sat', .90),
                  _bar('Sun', .72),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bigStat(IconData icon, String title, String value, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .14)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: color.withValues(alpha: .12),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: neonMutedText)),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(String day, double value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 27,
          height: 180 * value,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF1264A3), Color(0xFF00A896)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(day),
      ],
    );
  }
}

// ============================================================
// ACHIEVEMENTS
// ============================================================

class AchievementsPage extends StatelessWidget {
  final List<Achievement> achievements;
  final int challengeDays;
  final int energyScore;

  const AchievementsPage({
    super.key,
    required this.achievements,
    required this.challengeDays,
    required this.energyScore,
  });

  @override
  Widget build(BuildContext context) {
    final unlocked = achievements.where((a) => a.unlocked).length;

    return Scaffold(
      backgroundColor: achievementsBackground,
      appBar: AppBar(
        title: const Text(
          'Achievements',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      achievementsImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: const Color(0xFF3A211D)),
                    ),
                    Container(color: const Color(0xA6FF6B5F)),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Build momentum\nfrom small wins.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A3212), Color(0xFF2F2417)],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    '7-Day Energy Challenge',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$challengeDays / 7 days completed',
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: challengeDays / 7,
                    minHeight: 10,
                    backgroundColor: Color(0x553A2B18),
                    color: Color(0xFFFFD166),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Achievements',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$unlocked/${achievements.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 15),

            ...achievements.map((achievement) {
              return Card(
                color: const Color(0xFF1A1510),
                surfaceTintColor: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),

                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: achievement.unlocked
                        ? const Color(0xFF18312C)
                        : const Color(0xFF2B261F),
                    child: Icon(
                      achievement.icon,
                      color: achievement.unlocked
                          ? const Color(0xFF00A896)
                          : Colors.grey,
                    ),
                  ),

                  title: Text(
                    achievement.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(achievement.description),

                  trailing: Icon(
                    achievement.unlocked
                        ? Icons.check_circle
                        : Icons.lock_outline,
                    color: achievement.unlocked ? Colors.green : Colors.grey,
                  ),
                ),
              );
            }),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF18312C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Energy Score',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '$energyScore / 100',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final bool notificationsEnabled;
  final Function(bool) onNotificationChanged;
  final Future<bool> Function(String) onUserNameChanged;
  final VoidCallback onLogout;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.notificationsEnabled,
    required this.onNotificationChanged,
    required this.onUserNameChanged,
    required this.onLogout,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? profilePhotoBytes;

  Future<void> _chooseProfilePhoto() async {
    try {
      final pickedPhoto = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 900,
      );

      if (pickedPhoto == null) return;

      final bytes = await pickedPhoto.readAsBytes();
      if (mounted) {
        setState(() => profilePhotoBytes = bytes);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open image files: $error')),
        );
      }
    }
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    final controller = TextEditingController(text: widget.userName);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        bool saving = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: saving ? null : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: saving
                      ? null
                      : () async {
                          final newName = controller.text.trim();
                          if (newName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Username cannot be empty'),
                              ),
                            );
                            return;
                          }

                          setDialogState(() => saving = true);
                          final updated = await widget.onUserNameChanged(
                            newName,
                          );

                          if (updated && dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          } else if (dialogContext.mounted) {
                            setDialogState(() => saving = false);
                          }
                        },
                  child: saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: profileBackground,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: 122,
              height: 122,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: neonGold, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: neonGold.withValues(alpha: .35),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: ClipOval(
                child: profilePhotoBytes == null
                    ? Container(
                        color: const Color(0xFF18312C),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: const Color(0xFF55C98A),
                        ),
                      )
                    : Image.memory(profilePhotoBytes!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _chooseProfilePhoto,
              icon: const Icon(Icons.folder_open_outlined),
              label: const Text('Choose image from files'),
            ),
            const SizedBox(height: 15),
            Text(
              widget.userName,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(widget.userEmail, style: TextStyle(color: neonMutedText)),
            const SizedBox(height: 30),
            Card(
              color: const Color(0xFF1A1510),
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
                subtitle: const Text('Change your username'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showEditProfileDialog(context),
              ),
            ),
            Card(
              color: const Color(0xFF1A1510),
              surfaceTintColor: Colors.transparent,
              child: SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Notifications'),
                subtitle: const Text('Receive energy reminders'),
                value: widget.notificationsEnabled,
                onChanged: widget.onNotificationChanged,
              ),
            ),
            Card(
              color: const Color(0xFF1A1510),
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About Energy Saver'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Energy Saver',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(
                      Icons.energy_savings_leaf,
                      color: Colors.green,
                    ),
                    children: const [
                      Text(
                        'Energy Saver helps users reduce electricity wastage through reminders, device controls, energy tracking, challenges and achievements.',
                      ),
                    ],
                  );
                },
              ),
            ),
            Card(
              color: const Color(0xFF1A1510),
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('How to use'),
                        content: const Text(
                          'Go to Devices to control devices using ON/OFF switches. Complete energy reminders to improve your saving score. Check Statistics to view your energy savings.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: widget.onLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DEVICE ICON
// ============================================================

IconData deviceIcon(String type) {
  switch (type.toLowerCase()) {
    case 'light':
      return Icons.lightbulb;
    case 'fan':
      return Icons.mode_fan_off;
    case 'ac':
      return Icons.ac_unit;
    case 'refrigerator':
      return Icons.kitchen;
    case 'tv':
      return Icons.tv;
    default:
      return Icons.power;
  }
}
