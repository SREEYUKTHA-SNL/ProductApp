import 'package:flutter/material.dart';
import 'package:productapp/screens/addproduct.dart';
import 'package:productapp/screens/fetchapi.dart';
import 'package:productapp/screens/login.dart';
import 'package:productapp/screens/viewproduct.dart';
import 'package:productapp/services/firebaseauthservices.dart';
import 'package:productapp/widgets/containerwidget.dart';
 // Import the custom container

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
Future<void>logoutHandler()async{
  try{
await Firebaseauthservices().logout();
Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => LoginPage(), ));
  }catch(e){
print(e);
  }
}

  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add Product Container
            CustomContainer(
              title: 'Add Product',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add Product clicked')),
                );
              },
            ),
            
            // Fetch API Container
            CustomContainer(
              title: 'Fetch API',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FetchApiPage()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fetch API clicked')),
                );
              },
            ),
            
            // View Product Container
            CustomContainer(
              title: 'View Product',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Viewproduct()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('View Product clicked')),
                );
              },
            ),
            TextButton(onPressed: () {
              logoutHandler();
            }, child: Text('LOGOUT',style:TextStyle(color: Colors.teal,fontWeight: FontWeight.bold) ,))
          ],
        ),
      ),
    );
  }
}
