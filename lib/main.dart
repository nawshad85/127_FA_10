import 'package:flutter/material.dart';
import 'package:loginpage/pages/note_page.dart';
import 'package:loginpage/pages/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/loginpage.dart';
import 'pages/homepage.dart';
import 'pages/signup.dart';

void main() async{
  await Supabase.initialize(
      url: "https://axnsovgjxnatvcmynwyh.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF4bnNvdmdqeG5hdHZjbXlud3loIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxODYyNTcsImV4cCI6MjA3MTc2MjI1N30.hnOYcWnoAeqQHlm7fSFK3BBQoQ92xaos2pKPzQrL4UY"
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login demo page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

