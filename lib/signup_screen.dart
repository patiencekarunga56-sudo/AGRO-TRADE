import 'package:flutter/material.dart';
import 'customer_home_screen.dart';
import 'farmer_dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isFarmer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 48, color: Color(0xFF2E7D32)),
              const Text(
                'AgroTrade',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
              const Text('Fresh Food • Better Prices • Stronger Farmers', style: TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 24),
              const Text('Create Your Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Join AgroTrade and be part of a growing agricultural community', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 20),
              
              // Role Toggle Switcher
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFarmer = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isFarmer ? const Color(0xFF2E7D32) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.nature_people, color: isFarmer ? Colors.white : Colors.grey.shade700, size: 18),
                              const SizedBox(width: 6),
                              Text('Farmer', style: TextStyle(color: isFarmer ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFarmer = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !isFarmer ? const Color(0xFF2E7D32) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, color: !isFarmer ? Colors.white : Colors.grey.shade700, size: 18),
                              const SizedBox(width: 6),
                              Text('Customer', style: TextStyle(color: !isFarmer ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Inputs
              _buildFieldLabel('Full Name'),
              TextField(
                decoration: _inputDecoration('Enter your full name', Icons.person_outline),
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('Phone Number'),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Enter your phone number', Icons.phone_outlined),
              ),
              const SizedBox(height: 14),
              _buildFieldLabel('Password'),
              TextField(
                obscureText: true,
                decoration: _inputDecoration('Create a password', Icons.lock_outline),
              ),
              const SizedBox(height: 24),
              
              // Smart Sign Up Button (Navigates based on selected role)
              ElevatedButton(
                onPressed: () {
                  if (isFarmer) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text('Log In', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }
}