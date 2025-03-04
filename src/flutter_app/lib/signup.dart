import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state

  // Text controllers for user details
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a new user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;

      String uid = userCredential.user!.uid;

      // Save additional user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'nickname': _nicknameController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;

      // Navigate to the next page using a post frame callback to ensure context is valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/vehicle_info');
      });
    } on FirebaseAuthException catch (e) {
      // Handle errors (e.g., show a dialog with e.message)
      stderr.writeln('Error: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your first name'
                    : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your last name'
                    : null,
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: InputDecoration(labelText: 'Nickname'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a nickname'
                    : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'eMail'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your eMail address'
                    : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a password'
                    : null,
              ),
              SizedBox(height: 20),
              // Replace the Next button with a loading indicator when busy.
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _signup,
                      child: Text("Next"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
