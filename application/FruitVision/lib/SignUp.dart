import 'package:flutter/material.dart';
import '../login.dart';
import 'camera.dart';
import 'layout/screenlayout.dart';
import 'utils/auth.dart';
import 'widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isPasswordVisible = false; // State variable to manage password visibility


  void signUp(BuildContext context) {
    final _auth = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenLayout()),
              (Route<dynamic>route)=> false,);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                "Passwords don't match! Please confirm your password."),
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
        
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 50),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
        
                      colors: [Color(0xFF30551C), Color(0xFF30551C), Color(0xFF30551C)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5), // Couleur et opacité de l'ombre
                        spreadRadius: 5,  // Rayon de diffusion de l'ombre
                        blurRadius: 7,    // Flou de l'ombre
                        offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo Fruit Vision/logo fruit fetah.png', // Chemin vers votre logo
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 15), // Ajustez cette valeur comme nécessaire
                      Text(
                        'SignUp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        
        
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Espacement horizontal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  Text('Username'),
                  SizedBox(height: 10), // Ajout d'un espace entre le texte et le champ de texte
                  Container(
                    width: 150, // Ajustement de la largeur de la boîte de texte
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Username',
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
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color:  Color(0xFF30551C), width: 2.0), // Focused border color and width
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFC),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
        
                  const SizedBox(height: 10),
                  Text('Email'),
                  SizedBox(height: 10), // Ajout d'un espace entre le texte et le champ de texte
                  Container(
                    width: 250, // Ajustement de la largeur de la boîte de texte
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.grey,
                          fontWeight: FontWeight.normal,),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                            size: 24, // Ajustement de la taille de l'icône
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color:  Color(0xFF30551C), width: 2.0), // Focused border color and width
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFC),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Password'),
                  SizedBox(height: 10), // Ajout d'un espace entre le texte et le champ de texte
                  Container(
                    width: 250, // Ajustement de la largeur de la boîte de texte
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle the password visibility
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color:  Color(0xFF30551C), width: 2.0), // Focused border color and width
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFC),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Confirm Password'),
                  SizedBox(height: 10), // Ajout d'un espace entre le texte et le champ de texte
                  Container(
                    width: 250, // Ajustement de la largeur de la boîte de texte
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle the password visibility
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color:  Color(0xFF30551C), width: 2.0), // Focused border color and width
                        ),

                        filled: true,
                        fillColor: Color(0xFFFFFFC),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF30551C),
                      ),
                    ),
                    onTap: () {
                      signUp(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Already have an account?  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Container(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        
            // Ajoutez le reste de votre UI ici
            // ...
          ],
        ),
      ),
    );

  }
}