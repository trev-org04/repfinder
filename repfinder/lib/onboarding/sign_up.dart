
import 'package:repfinder/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: {
          'first_name': firstNameController.text.trim(), // Store first name in user metadata
        },
      );

      final User? user = res.user;

      if (user != null) {
        Navigator.pushNamed(context, '/home'); // Navigate to home if successful
      }
    } catch (e) {
      print('Sign Up Error: $e'); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Rep Finder'.toUpperCase(),
          style: GoogleFonts.inter(
            color: AppColors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready to',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[AppColors.lavender, AppColors.periwinkle],
                        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
                  ),
                  Text(
                    'Get Started?',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[AppColors.lavender, AppColors.periwinkle],
                        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter your details below to sign up!',
                    style: GoogleFonts.inter(
                      color: AppColors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // First Name Input Field
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                    ),
                    style: GoogleFonts.inter(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Email Input Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                    ),
                    style: GoogleFonts.inter(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password Input Field
                  TextField(
                    controller: passwordController,
                    obscureText: true, // Hide password input
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                    ),
                    style: GoogleFonts.inter(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: signUp, // Calls sign-up function
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.white),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 17.5),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  child: Text(
                    'Sign Up'.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
