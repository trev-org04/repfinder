import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key});

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
                  Text(
                    'No Wait,',
                    style: TextStyle(
                      fontFamily: 'Polymath',
                      fontSize: 35,
                      fontVariations: [FontVariation('wght', 700)],
                      color: AppColors.white,
                      letterSpacing: -0.5,
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
                      'Just Lift.',
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 45,
                        fontVariations: [FontVariation('wght', 700)],
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  Text(
                    'Get real-time machine availability and maximize your workout—no more wasting time waiting for equipment.',
                    style: GoogleFonts.inter(
                      color: AppColors.white.withOpacity(0.5),
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
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[AppColors.lavender, AppColors.periwinkle],
                    ).createShader(bounds);
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 17.5),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                          side: BorderSide(
                            width: 2.0,
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 0),
                      ),
                    ),
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Polymath',
                        fontSize: 15,
                        fontVariations: [FontVariation('wght', 900)],
                        color: AppColors.white,
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
