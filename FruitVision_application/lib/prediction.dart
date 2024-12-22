import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisplayAnalysisResultsScreen extends StatelessWidget {
  final String imagePath;
  final dynamic type;
  final dynamic? resultText;

  DisplayAnalysisResultsScreen({required this.imagePath, required this.type, required this.resultText });

  Future<ImageProvider> getImage() async {
    final response = await http.get(Uri.parse(imagePath));
    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFE9EEE9),
      appBar: AppBar(
        title: Text(
          'Analysis Results',
          style: TextStyle(
            color: Colors.white,  // Set text color to white
          ),
        ),
        backgroundColor: Color(0xFF30551C) ,

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 20, 45),
              child: FutureBuilder<ImageProvider>(
                future: getImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Container(
                      //width: 200, // Set width of the image
                      //height: 350, // Set height of the image
                      child: Image(
                        image: snapshot.data as ImageProvider<Object>,
                        fit: BoxFit.cover, // Adjusts the size of the image to cover the box
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),

            ),
            Container(
              padding: EdgeInsets.all(25),
              width: 310,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type != "Unknown")
                    Row(
                      children: [
                        Text(
                          'The type of fruit:  ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '$type',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Text(
                    resultText!, // Display resultText if not "Unknown"
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),

            ),

          ],
        ),
      ),
    );
  }
}

