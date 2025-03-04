import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Dropdown selections
  String? _selectedVehicleType;
  String? _selectedFuelType;

  // Dropdown options
  final List<String> _vehicleTypes = ['SUV', 'Sedan', 'Hatchback'];
  final List<String> _fuelTypes = ['Diesel', 'Hybrid', 'E85', 'Petrol'];

  // Controller for vehicle age
  final _yearOfRegistrationController = TextEditingController();

  @override
  void dispose() {
    _yearOfRegistrationController.dispose();
    super.dispose();
  }

  Future<void> _dataSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String? uid;

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        uid = currentUser.uid;
      } else {
        return;
      }

      // Save additional user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'yearOfRegistration': _yearOfRegistrationController.text.trim(),
        'VehicleType': _selectedVehicleType,
        'FuelType': _selectedFuelType,
      });
      if (!mounted) return;

      // Navigate to the next page using a post frame callback to ensure context is valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
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
        title: Text("Vehicle Information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Vehicle Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Vehicle Type'),
                value: _selectedVehicleType,
                items: _vehicleTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedVehicleType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a vehicle type' : null,
              ),
              // Fuel Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Fuel Type'),
                value: _selectedFuelType,
                items: _fuelTypes.map((fuel) {
                  return DropdownMenuItem(
                    value: fuel,
                    child: Text(fuel),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedFuelType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a fuel type' : null,
              ),
              // Vehicle Age Input
              TextFormField(
                controller: _yearOfRegistrationController,
                decoration: InputDecoration(labelText: 'Year of registration'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration year of the vehicle';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _dataSave,
                      child: Text("Next"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
