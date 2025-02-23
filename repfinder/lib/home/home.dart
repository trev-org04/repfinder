import 'package:flutter/material.dart';
import 'package:repfinder/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = "Loading...";
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = supabase.auth.currentUser;
    if (user != null && user.userMetadata != null) {
      setState(() {
        firstName = user.userMetadata!['first_name'] ?? "User";
      });
    }
  }

  // called when flutter needs to rebuild ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Hello, $firstName!',
            style: TextStyle(
              fontFamily: 'Polymath',
              fontSize: 24,
              fontVariations: [FontVariation('wght', 700)],
              color: AppColors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.offblack,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        radius: 70,
                        lineWidth: 10,
                        percent: 0.7,
                        linearGradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        backgroundColor: AppColors.white,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: ShaderMask(
                          shaderCallback:
                              (bounds) => LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.purple,
                                ], // Gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                          child: Text(
                            '70%',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color:
                                  Colors
                                      .white, // Required but overridden by shader
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'North Recreation Center',
                            style: TextStyle(
                              fontFamily: 'Polymath',
                              fontSize: 22,
                              fontVariations: [FontVariation('wght', 700)],
                              color: AppColors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'The gym is almost at full capacity!',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Enables horizontal scrolling
                child: Row(
                  children: List.generate(7, (index) {
                    List<String> muscleGroups = [
                      'Abs',
                      'Biceps',
                      'Back',
                      'Chest',
                      'Legs',
                      'Shoulders',
                      'Triceps',
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = index;
                              }),
                            },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == index
                                    ? AppColors.periwinkle
                                    : AppColors.offblack,
                            // color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            muscleGroups[index].toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight:
                                  _selectedIndex == index
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                              color:
                                  _selectedIndex == index
                                      ? AppColors.white
                                      : AppColors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.offblack,
                    ),
                  ),
                ),
                SizedBox(width:30),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.offblack,
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
