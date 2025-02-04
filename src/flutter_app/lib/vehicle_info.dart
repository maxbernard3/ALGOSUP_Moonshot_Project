import 'package:flutter/material.dart';

class VehicleInfoScreen extends StatefulWidget {
  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown selections
  String? _selectedVehicleType;
  String? _selectedFuelType;

  // Dropdown options
  final List<String> _vehicleTypes = ['SUV', 'Sedan', 'Hatchback'];
  final List<String> _fuelTypes = ['Diesel', 'Hybrid', 'E85', 'Petrol'];

  // Controller for vehicle age
  final _vehicleAgeController = TextEditingController();

  @override
  void dispose() {
    _vehicleAgeController.dispose();
    super.dispose();
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
                controller: _vehicleAgeController,
                decoration: InputDecoration(labelText: 'Age of the Vehicle'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age of the vehicle';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to the placeholder home page.
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (Route<dynamic> route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
