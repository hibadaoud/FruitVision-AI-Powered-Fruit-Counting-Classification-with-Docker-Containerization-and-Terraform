import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../settings.dart';
import '../profilesettings.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                const Expanded(flex: 2, child: _TopPortion()),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                    child: Column(
                      children: [
                        Text(userData['username'],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 57, 57, 57),
                            )),
                        const SizedBox(height: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    currentUser.email!,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 57, 57, 57),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                    height: 1.0,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileSettingsScreen()));
                                  },
                                  title: Text(
                                    'Profile Settings',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 57, 57, 57),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 57, 57, 57)),
                                ),
                                Divider(
                                    height: 3.0,
                                    color: Color.fromARGB(255, 57, 57, 57)),
                                ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Color.fromARGB(255, 212, 223, 212),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                child: const Text(
                                                  ('Close'),
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 0, 0, 0)),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()));
                                                },
                                                child: const Text(
                                                    'Sign Out',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.black)))
                                          ],
                                          title: const Text('Sign Out',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          content: const Text(
                                              'You are signing out.'),
                                        ));
                                  },
                                  title: Text('Sign Out',
                                      style: TextStyle(
                                          color:
                                          Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold)),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                Divider(
                                    height: 1.0,
                                    color: Color.fromARGB(255, 23, 0, 0)),
                                SizedBox(height: 8.0),
                                SizedBox(height: 8.0),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Container(
        margin: const EdgeInsets.only(bottom: 100),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [ Color(0xFF30551C),  Color(0xFF30551C),  Color(0xFF30551C)],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20.0, 30.0, 20.0, 50.0), // Ajoutez du padding autour du cercle
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEADB),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 60,
                color:  Color(0xFF30551C),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}