import 'package:flutter/material.dart';
import 'package:loginpage/auth/auth_gate.dart';
import 'package:loginpage/pages/LoginPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('images/bg.png', fit: BoxFit.cover)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthGate()),
                  );
                }, child: Text("Get Started"))
              ],
            ),
          )
        ],
      )
    );
  }
}