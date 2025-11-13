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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Halaman awal: Login (Google Sign-In)
      home: const LoginScreen(),

      // Rute tambahan setelah login sukses
      routes: {'/main': (context) => const MainNavigationWidget()},
    );
  }
}

/// Widget utama setelah login berhasil
class MainNavigationWidget extends StatefulWidget {
  const MainNavigationWidget({super.key});

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens => [
    DashboardScreen(onNavigate: _onItemTapped),
    const CatatScreen(),
    const RiwayatScreen(),
    const LaporanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
