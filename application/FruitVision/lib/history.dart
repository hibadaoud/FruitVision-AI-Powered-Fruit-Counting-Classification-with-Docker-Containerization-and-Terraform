import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Pour convertir les données en format JSON
import 'package:flutter_dotenv/flutter_dotenv.dart';


class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> historyData = []; // Stocker les données de l'historique
  final  HISTORY_API = dotenv.env['HISTORY_API'];
  @override
  void initState() {
    super.initState();
    fetchHistory(); // Appeler la fonction au démarrage
  }

  Future<void> fetchHistory() async {
    final response = await http.get(Uri.parse(HISTORY_API! + '/api/history'));

    if (response.statusCode == 200) {
      setState(() {
        historyData = json.decode(response.body); // Met à jour l'état avec les données
      });
    } else {
      // Gérez les erreurs ici, par exemple en montrant un message à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la récupération de l\'historique')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Application',
      theme: ThemeData(

        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'History Predictions',
            style: TextStyle(
              color: Colors.white,  // Set text color to white
            ),
          ),
          backgroundColor: Color(0xFF30551C) ,

        ),
        body: historyData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(historyData[index]['type']),
              subtitle: Text('number: ${historyData[index]['resultText']}'),
              // leading: Image.network(historyData[index]['full_url'], width: 100, height: 100, fit: BoxFit.cover),
              leading: Image.network(
                historyData[index]['full_url'] ?? 'https://via.placeholder.com/150',
                width: 100,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Affichez un texte, une image de repli, ou tout autre widget ici si l'image ne peut pas être chargée
                  return const Icon(Icons.error);  // Ici, j'utilise une icône d'erreur comme exemple
                },
              ),


            );
          },
        ),
      ),
    );

  }
}