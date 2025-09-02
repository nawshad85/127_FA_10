import 'package:flutter/material.dart';
import 'package:loginpage/pages/profilepage.dart';
import 'package:loginpage/pages/signup.dart';

import '../auth/auth_service.dart';

// keyboard_arrow_left_sharp

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService = AuthService();
  void login() async{
    final email = _emailController.text;
    final password = _passwordController.text;
    // print("Email: $email, Password: $password");
    try {
      await authService.singInWithEmailPassword(email, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successfull")));
      }
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("images/bg.png", fit: BoxFit.fill)),
          Positioned(
              top: 35,
              left: 5,
              child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.keyboard_arrow_left_sharp, size: 40, color: Colors.white),)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.8 * MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 0.06 * MediaQuery.of(context).size.height),
                  Text("Welcome", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color(0xFF7B4BF8)
                  ),),
                  SizedBox(height: 0.04 * MediaQuery.of(context).size.height),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 0.4 * MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF776DBD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                      ),
                      child: Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(fontSize: 15)),
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      }, child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}