
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'customer_home_screen.dart';
import 'farmer_dashboard_screen.dart';
import 'orders_screen.dart';

void main() {
  runApp(const AgroTradeApp());
}

class AgroTradeApp extends StatelessWidget {
  const AgroTradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroTrade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF1B5E20),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF4CAF50),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
        fontFamily: 'Roboto',
      ),
      home: const MainScreenSwitcher(),
    );
  }
}

/// Screen Switcher for Easy Testing of all 6 UI screens
class MainScreenSwitcher extends StatefulWidget {
  const MainScreenSwitcher({super.key});

  @override
  State<MainScreenSwitcher> createState() => _MainScreenSwitcherState();
}

class _MainScreenSwitcherState extends State<MainScreenSwitcher> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SplashScreen(),
    LoginScreen(),
    SignUpScreen(),
    CustomerHomeScreen(),
    FarmerDashboardScreen(),
    OrdersScreen(),
  ];

  final List<String> _screenTitles = const [
    "Splash Screen",
    "Login",
    "Sign Up",
    "Customer Home",
    "Farmer Dashboard",
    "Orders",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        title: Text(
          "Preview: ${_screenTitles[_currentIndex]}",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.screen_share, color: Colors.white),
            onSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context) => List.generate(
              _screens.length,
              (index) => PopupMenuItem(
                value: index,
                child: Text(_screenTitles[index]),
              ),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}