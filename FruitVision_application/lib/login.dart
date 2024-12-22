import 'package:flutter/material.dart';
import '../SignUp.dart';
import 'layout/screenlayout.dart';
import 'utils/auth.dart';
import 'widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // State variable to manage password visibility


  void login(BuildContext context) async {

    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenLayout()),
            (Route<dynamic>route) => false,);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(e.toString()),
            ),
      );
    }

  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                      colors: [
                        Color(0xFF30551C),
                        Color(0xFF30551C),
                        Color(0xFF30551C)
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
        
        
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo Fruit Vision/logo fruit fetah.png',
                        // Chemin vers votre logo
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 15),
                      // Ajustez cette valeur comme nécessaire
                      Text(
                        'Login',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // Espacement horizontal
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
        
                  const SizedBox(height: 60),
                  Text('Email'),
                  SizedBox(height: 10),
                  // Ajout d'un espace entre le texte et le champ de texte
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Password'),
                  SizedBox(height: 10),
                  // Ajout d'un espace entre le texte et le champ de texte
                  Container(
                    width: 250, // Ajustement de la largeur de la boîte de texte
                    child: TextField(
                      obscureText: !_isPasswordVisible, // Hide/show password based on the state
                      controller: _passwordController,
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      child: const Text(
                        'Login',
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
                      login(context); // Disable the button when loading

                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Don't have an account?  ",
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
                                  builder: (context) => SignupScreen()));
                        },
                        child: Container(
                          child: Text(
                            "Sign Up",
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