// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../widgets/text_field_input.dart';
import '../profile.dart';


class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
          backgroundColor:  Color(0xFF30551C),
          title: Text(
            'Profile Settings',
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },

              child: Text(
                'Save',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

            ),
          ],
          toolbarHeight: 90.0,
        ),
        body: Column(
          children: [
            Container(
                width: 550,
                margin: EdgeInsetsDirectional.only(start: 30,end: 30,top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Text(
                        'Username',style: TextStyle(color: const Color.fromARGB(255, 101, 97, 97),fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                  width: 290,
                  height: 50, // Ajustement de la largeur de la boîte de texte
                  child: TextField(
                    
                    decoration: InputDecoration(
                      hintText: 'New Username',
                      hintStyle: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.normal,),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 24, // Ajustement de la taille de l'icône
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color(0xFF30551C), width: 3.0)
                      ),
                      filled: true,
                      fillColor: Color(0xFFE9EEE9),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                  ],
                )),
            Container(
                width: 400,
                margin: EdgeInsetsDirectional.only(start: 30,end: 30,top: 0),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),

                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Text(
                        'New Password',
                        style: TextStyle(color: const Color.fromARGB(255, 101, 97, 97),fontWeight: FontWeight.bold),
                      ),
                    ),
                  Container(
                  width: 290,
                  height: 50, // Ajustement de la largeur de la boîte de texte
                  child: TextField(
                    
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      hintStyle: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.normal,),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 24, // Ajustement de la taille de l'icône
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color(0xFF30551C), width: 3.0)
                      ),
                      filled: true,
                      fillColor: Color(0xFFE9EEE9),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                    SizedBox(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Text(
                        'Confirm Password',
                        style: TextStyle(color: const Color.fromARGB(255, 101, 97, 97),fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                  width: 290,
                  height: 50, // Ajustement de la largeur de la boîte de texte
                  child: TextField(
                    
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.normal,),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 24, // Ajustement de la taille de l'icône
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color(0xFF30551C), width: 3.0)
                      ),
                      filled: true,
                      fillColor: Color(0xFFE9EEE9),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 30),  // Espacement au-dessus du bouton
              child: SizedBox(
                width: 150, // Largeur du bouton
                height: 50, // Hauteur du bouton
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Pour s'assurer que le Row ne prend pas toute la largeur
                    children: [
                      SizedBox(width: 8), // Espacement avant le texte
                      Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 17, // Taille du texte augmentée
                          fontWeight: FontWeight.normal, // Gras
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF30551C), // Couleur de fond
                    onPrimary: Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    elevation: 5, // Élévation pour l'ombre
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bords plus arrondis
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Espacement interne augmenté
                  ),
                ),
              ),
            )



          ],
        ));
  }
}