import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EEE9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Center(
                child: Image.asset(
                  'assets/logo Fruit Vision/vert foncé shih.png', // Replace with your image path
                  width: 290,
                  /*height: 150,*/
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 25),
              child: SizedBox(
                width: 50, // Set your desired width here
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF30551C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 50),
              child: SizedBox(
                width: 50, // Set your desired width here
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF30551C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            _user != null ? _userInfo() : _googleSignInButton(),

          ],
        ),
      ),
    );
  }
  Widget _googleSignInButton(){
    return Center(child: SizedBox(
      height: 50,
      child: SignInButton(
        Buttons.google,
        text:"Sign up with google",
        onPressed:_handleGoogleSignIn ,)
    ),);
  }
  Widget _userInfo() {
    return SizedBox();
  }
  void _handleGoogleSignIn(){
      try{
        GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
        _auth.signInWithProvider(_googleAuthProvider);
      }
      catch (error){
        print(error);
      }
    }

}
