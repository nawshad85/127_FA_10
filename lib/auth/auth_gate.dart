import 'package:flutter/material.dart';
import 'package:loginpage/pages/LoginPage.dart';
import 'package:loginpage/pages/profilepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          final session = snapshot.hasData?snapshot.data!.session:null;
          if(session == null){
            return LoginPage();
          }
          else{
            return ProfilePage();
          }
        }
    );
  }
}
