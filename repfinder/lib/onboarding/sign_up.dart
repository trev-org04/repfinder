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
          'first_name':
              firstNameController.text
                  .trim(), // Store first name in user metadata
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
          style: TextStyle(
            fontFamily: 'Polymath',
            fontSize: 20,
            fontVariations: [FontVariation('wght', 900)],
            color: AppColors.white,
            letterSpacing: -0.5,
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
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: <Color>[
                          AppColors.lavender,
                          AppColors.periwinkle,
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Ready to',
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 30,
                        fontVariations: [FontVariation('wght', 700)],
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: <Color>[
                          AppColors.lavender,
                          AppColors.periwinkle,
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Get Started?',
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Enter an email and password below to get started!',
                      style: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // First Name Input Field
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'First Name'.toUpperCase(),
                        hintStyle: TextStyle(
                          fontFamily: 'Polymath',
                          fontSize: 16,
                          fontVariations: [FontVariation('wght', 700)],
                          color: AppColors.white.withOpacity(0.5),
                          letterSpacing: -0.5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 16,
                        fontVariations: [FontVariation('wght', 700)],
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  // Email Input Field
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'Email'.toUpperCase(),
                        hintStyle: TextStyle(
                          fontFamily: 'Polymath',
                          fontSize: 16,
                          fontVariations: [FontVariation('wght', 700)],
                          color: AppColors.white.withOpacity(0.5),
                          letterSpacing: -0.5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 16,
                        fontVariations: [FontVariation('wght', 700)],
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  // Password Input Field
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'Email'.toUpperCase(),
                        hintStyle: TextStyle(
                          fontFamily: 'Polymath',
                          fontSize: 16,
                          fontVariations: [FontVariation('wght', 700)],
                          color: AppColors.white.withOpacity(0.5),
                          letterSpacing: -0.5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 16,
                        fontVariations: [FontVariation('wght', 700)],
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[AppColors.lavender, AppColors.periwinkle],
                    ).createShader(bounds);
                  },
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 17.5),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 0),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 15,
                        fontVariations: [FontVariation('wght', 900)],
                        color: AppColors.black,
                        letterSpacing: -0.5,
                      ),
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
