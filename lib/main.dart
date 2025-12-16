import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/dashboard_screen.dart';
import 'screens/catat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/riwayat_screen.dart';
import 'screens/laporan_screen.dart';
import 'widgets/bottom_nav_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MonitoringApp());
}

class MonitoringApp extends StatelessWidget {
  const MonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Monitoring Mobil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        primaryColor: Colors.blue.shade700,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {'/main': (context) => const MainNavigationWidget()},
    );
  }
}

class MainNavigationWidget extends StatefulWidget {
  const MainNavigationWidget({super.key});

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // LOCK untuk cegah swipe saat scroll vertical
  bool _isVerticalScroll = false;
  double _startX = 0;
  double _startY = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  List<Widget> get _screens => [
    DashboardScreen(onNavigate: _onItemTapped),
    const CatatScreen(),
    const RiwayatScreen(),
    const LaporanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detect arah awal
      onPanStart: (d) {
        _startX = d.localPosition.dx;
        _startY = d.localPosition.dy;
      },

      onPanUpdate: (d) {
        double diffX = (d.localPosition.dx - _startX).abs();
        double diffY = (d.localPosition.dy - _startY).abs();

        // Jika swipe lebih dominan vertikal → kunci swipe horizontal
        if (diffY > diffX) {
          if (!_isVerticalScroll) {
            setState(() => _isVerticalScroll = true);
          }
        } else {
          if (_isVerticalScroll) {
            setState(() => _isVerticalScroll = false);
          }
        }
      },

      onPanEnd: (_) => setState(() => _isVerticalScroll = false),

      child: Scaffold(
        backgroundColor: Colors.grey.shade50,

        body: PageView(
          controller: _pageController,

          // Jika user scroll vertical → swipe page dimatikan
          physics: _isVerticalScroll
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),

          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },

          children: _screens,
        ),

        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
