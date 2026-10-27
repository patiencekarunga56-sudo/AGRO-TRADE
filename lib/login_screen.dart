import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'customer_home_screen.dart';
import 'farmer_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool isFarmerRole = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.eco, size: 50, color: Color(0xFF2E7D32)),
              const Text(
                'AgroTrade',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
              const Text(
                'Fresh Food • Better Prices • Stronger Farmers',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Log in to continue to your account', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 24),
              // Input Fields
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone_outlined),
                  hintText: 'Phone number or email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => obscurePassword = !obscurePassword),
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              // Checkbox & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        activeColor: const Color(0xFF2E7D32),
                        onChanged: (val) => setState(() => rememberMe = val ?? false),
                      ),
                      const Text('Remember me', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Log In Button
              ElevatedButton(
                onPressed: () {
                  if (isFarmerRole) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerHomeScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
                    },
                    child: const Text('Sign Up', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('or', style: TextStyle(color: Colors.grey))),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              // Account Type Selector Cards
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isFarmerRole = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isFarmerRole ? const Color(0xFFE8F5E9) : Colors.white,
                          border: Border.all(color: isFarmerRole ? const Color(0xFF2E7D32) : Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.nature_people, color: Color(0xFF2E7D32)),
                            SizedBox(width: 8),
                            Text('I am a Farmer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isFarmerRole = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isFarmerRole ? const Color(0xFFE8F5E9) : Colors.white,
                          border: Border.all(color: !isFarmerRole ? const Color(0xFF2E7D32) : Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.person, color: Color(0xFF2E7D32)),
                            SizedBox(width: 8),
                            Text('I am a Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}