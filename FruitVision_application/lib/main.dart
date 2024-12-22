import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';

import 'login.dart';

import 'SignUp.dart';
import 'layout/screenlayout.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/auth_gate.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String mood="" ;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // Set back arrow color here
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (_) => const HomePage(), //
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/screen_layout': (_) => const ScreenLayout(),


        //'/Song': (_) => const SongScreen(),
        //'/playlist': (_) => const PlaylistScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds:3), () {
      // After 1 second, navigate to the login page
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EEE9),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 30),
                child: Center(
                  child: Image.asset(
                    'assets/logo Fruit Vision/logo.png', // Replace with your image path
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Text(
                'Welcome ',
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF30551C),
                    fontWeight: FontWeight.bold
                ),
              ),
              const Text(
                'To',
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF30551C),
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40, // Width of the line
                    height: 2, // Thickness of the line
                    color: Color(0xFF30551C), // Color of the line
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10), // Spacing around the text
                    child: const Text(
                      'Fruit Vision',
                      style: TextStyle(
                          fontSize: 43,
                          color: Color(0xFF30551C),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    width: 40, // Width of the line
                    height: 2, // Thickness of the line
                    color: Color(0xFF30551C), // Color of the line
                  ),
                ],
              ),
            ],
          ),
          /*Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/images/supcom.png", // Replace with your image path
                width: 300,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}






/*class _CustomNavBar extends StatefulWidget {
  const _CustomNavBar();

  @override
  State<_CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<_CustomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/history'); // Navigate to NotesPage
        break;
      case 1:
        Navigator.of(context).pushNamed('/camera'); // Navigate to NotesPage
        break;
      case 2:
        Navigator.of(context).pushNamed('/profile');
        break;
    // Add more cases if needed for additional items
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your custom height
    const double customNavBarHeight = 65.0;

    return SizedBox(
      height: customNavBarHeight, // Set the height of the BottomNavigationBar
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF30551C),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined, size: 30),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}*/


