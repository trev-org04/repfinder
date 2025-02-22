import 'package:flutter/material.dart';
import 'package:repfinder/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
  String firstName = "Loading..."; // default text

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
            style: GoogleFonts.inter(fontSize: 20),
          ),
        ),
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Ohio State North Rec',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [AppColors.lavender, AppColors.periwinkle],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 17)),
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      radius: 85,
                      lineWidth: 8,
                      percent: 0.7,
                      progressColor: AppColors.navy,
                      backgroundColor: AppColors.white,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        '70%',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Gym Capacity',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Row(
                children: List.generate(7, (index) {
                  List<String> muscleGroups = [
                    'Abs',
                    'Back',
                    'Biceps',
                    'Chest',
                    'Legs',
                    'Shoulders',
                    'Triceps',
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ), // Spacing between containers
                    child: Container(
                      width: 110,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        muscleGroups[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [AppColors.lavender, AppColors.periwinkle],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4), // Border thickness
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black, // Inner container background
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // Slightly smaller radius
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
