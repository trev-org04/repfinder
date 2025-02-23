import 'package:flutter/material.dart';
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
  int _selectedIndex = 0;

  // called when flutter needs to rebuild ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Hello Aneesh!', style: GoogleFonts.inter(fontSize: 20)),
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
                gradient: LinearGradient(
                  colors: [AppColors.lavender, AppColors.periwinkle],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                        progressColor: AppColors.navy,
                        backgroundColor: AppColors.white,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '70%',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy,
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
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
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
            SingleChildScrollView(
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
                                  : Colors.transparent,
                          border: Border.all(
                            color:
                                _selectedIndex == index
                                    ? Colors.transparent
                                    : AppColors.white.withOpacity(0.5),
                            width: 2.5,
                          ),
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
                                    : FontWeight.w400,
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
          ],
        ),
      ),
    );
  }
}
