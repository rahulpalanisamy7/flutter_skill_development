import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../HomeScreen.dart'; // Assuming Supabase is properly initialized

class RegisterScreen extends StatefulWidget {

  final String title;

  const RegisterScreen({super.key, required this.title});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final storage = const FlutterSecureStorage(); // Secure storage instance
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    emailController.text = "admin@gmail.com";
    passwordController.text = "admin@123";
    confirmPasswordController.text = "admin@123";
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      setState(() => _isLoading = false);
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.user != null) {
        Fluttertoast.showToast(msg: "Registration Successful!");
        await signIn();
      } else {
        Fluttertoast.showToast(msg: "Registration failed.");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: ${error.toString()}");
      print("Error: ${error.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> signIn() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.session != null) {
        await storage.write(
            key: 'session', value: response.session!.accessToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(title: 'Home')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    }
  }

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
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Full Name is required' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value!.isEmpty ? 'Email is required' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        validator: (value) => value!.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Confirm your password'
                            : null,
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: _isLoading ? null : _signUp,
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ]),
                          ),
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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