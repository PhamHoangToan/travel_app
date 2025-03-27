import 'package:flutter/material.dart';
import 'package:travel_app/representation/screen/login_screen.dart';
import 'package:travel_app/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/images.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField("Username", Icons.person, (val) => userName = val),
                _buildTextField("Email", Icons.email, (val) => email = val),
                _buildTextField("Password", Icons.lock, (val) => password = val, isPassword: true),
                const SizedBox(height: 20),
                _buildRegisterButton(),
                const SizedBox(height: 20),
                _buildLoginRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, Function(String?) onSave,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onSaved: onSave,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label cannot be empty";
          }
          if (label == "Email" && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return "Invalid email format";
          }
          if (label == "Password" && value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (globalFormKey.currentState!.validate()) {
          globalFormKey.currentState!.save();
          setState(() {
            isApiCallProcess = true;
          });

          bool isRegistered = await APIService.register(userName!, email!, password!);

          setState(() {
            isApiCallProcess = false;
          });

          if (isRegistered) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration successful. Please login."))
            );
            Navigator.pushNamed(context, LoginScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration failed. Try again."))
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text("Register", style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  Widget _buildLoginRedirect() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
      child: Text("Already have an account? Login", style: TextStyle(color: Colors.white)),
    );
  }
}
