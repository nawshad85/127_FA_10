import 'package:flutter/material.dart';
import 'package:loginpage/pages/note_page.dart';

import '../auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  void signOut() async{
    await AuthService().signOut();
  }
  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentEmail!),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotePage()
                )
              );
            }, child: Text("notepage"))
          ],
        )
      ),
    );
  }
}
