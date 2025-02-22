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
                    'No Wait,',
                    style: GoogleFonts.inter(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
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
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
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
                      style: GoogleFonts.inter(
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
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
                      style: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.5),
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
