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
                      'Welcome Back',
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
                      'to the Future.',
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
                      'Enter your email and password below to continue your journey!',
                      style: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: _emailController,
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
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 17.5),
                        hintText: 'Password'.toUpperCase(),
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
