import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repfinder/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  Future<void> _supabaseSignIn() async {
    AuthResponse res = await supabase.auth.signInWithPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res.user != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.toString()),
          backgroundColor: AppColors.lavender,
        ),
      );
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
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
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
                  Text(
                    'Enter an email and password below to get started!',
                    style: GoogleFonts.inter(
                      color: AppColors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'Email'.toUpperCase(),
                        hintStyle: GoogleFonts.inter(
                          color: AppColors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
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
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'Password'.toUpperCase(),
                        hintStyle: GoogleFonts.inter(
                          color: AppColors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
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
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
                    onPressed: _supabaseSignIn,
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
                      'Sign In'.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
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
