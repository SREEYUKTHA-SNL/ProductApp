import 'package:flutter/material.dart';
import 'package:productapp/screens/addproduct.dart'; // Adjust the import as needed

class FetchApiPage extends StatelessWidget {
  // Sample data for the list
  final List<String> apiDataOptions = [
    'Api data',
    'Api data',
    'Api data',
    'Api data',
    'Api data',


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: apiDataOptions.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  apiDataOptions[index],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


