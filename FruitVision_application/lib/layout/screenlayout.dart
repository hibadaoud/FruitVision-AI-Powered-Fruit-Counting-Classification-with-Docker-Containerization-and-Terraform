import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../camera.dart';
import '../settings.dart';
import '../profile.dart';
import '../utils/auth.dart';
import '../history.dart';




class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int index = 1;
  final List<Widget> screens = [
    History(),
    Camera(),
    AppSettingsScreen(),
    ProfileScreen(),
  ];

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Color(0xFF30551C)
              , // Couleur dorée définie dans votre fichier colors.dart
              indicatorColor: Colors.transparent, // Supprime l'indicateur de sélection
              labelTextStyle: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                final isSelected = states.contains(MaterialState.selected);
                return TextStyle(
                  fontSize: 14,
                  height: 0.8,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Color(0xFFE9EEE9) : Colors.white70,
                );
              }),
            ),
            child: NavigationBar(
              height: 60, // Hauteur ajustée selon votre design
              selectedIndex: index,
              onDestinationSelected: (int newIndex) {
                setState(() => index = newIndex);
              },
              destinations: [
                NavigationDestination(
                  icon: _buildIcon(Icons.history, 0),
                  selectedIcon: _buildIcon(Icons.history, 0),
                  label: 'History',
                ),
                NavigationDestination(
                  icon: _buildIcon(Icons.camera_alt_outlined, 1),
                  selectedIcon: _buildIcon(Icons.camera_alt, 1),
                  label: 'Camera',
                ),
                NavigationDestination(
                  icon: _buildIcon(Icons.settings, 3),
                  selectedIcon: _buildIcon(Icons.settings, 3),
                  label: 'Settings',
                ),
                NavigationDestination(
                  icon: _buildIcon(Icons.account_circle_outlined, 3),
                  selectedIcon: _buildIcon(Icons.account_circle, 3),
                  label: 'Profile',
                ),
              ],

            )
        ) );
  }


  Widget _buildIcon(IconData icon, int destinationIndex) {
    // Utilisez une Column pour inclure à la fois l'icône et le label avec le bon espacement
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: index == destinationIndex ? Color(0xFFE9EEE9) : Colors.white70,
          size: 25,
        ),
        SizedBox(height: 4), // Espace entre l'icône et le texte

      ],
    );
  }
  String _labelText(int destinationIndex) {
    switch (destinationIndex) {
      case 0:
        return 'History';
      case 1:
        return 'Camera';
      case 2:
        return 'Settings';
      case 3:
        return 'Profile';
      default:
        return '';
    };


  }
}