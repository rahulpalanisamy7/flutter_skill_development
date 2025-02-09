import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // Control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView( // Prevent overflow
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          labelText: 'Gmail',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: _obscurePassword, // Toggle password visibility
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(title: "Home"),
                            ),
                          );
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ]),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
