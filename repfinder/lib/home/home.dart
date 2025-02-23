import 'package:flutter/material.dart';
import 'package:repfinder/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';

void main() {
  runApp(HomePage());
}

class Machine {
  final String name;
  final String muscleGroup;
  final String status;
  final int id;
  int capacity;

  Machine({
    required this.name,
    required this.muscleGroup,
    required this.status,
    required this.id,
    required this.capacity,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = "Loading...";
  int _selectedIndex = 0;
  List<Machine> machines = [];
  List<Machine> selectedMachines = [];
  double capacityRatio = 0.0;
  List<String> muscleGroups = [
    'Abs',
    'Biceps',
    'Back',
    'Chest',
    'Legs',
    'Shoulders',
    'Triceps',
    'Cardio',
  ];

  @override
  void initState() {
    super.initState();
    fetchUserName();
    fetchMachines();
    fetchCapacityData();
    subscribeToMachineChanges();
  }

  void fetchUserName() async {
    final user = supabase.auth.currentUser;
    if (user != null && user.userMetadata != null) {
      setState(() {
        firstName = user.userMetadata!['first_name'] ?? "User";
      });
    }
  }

  Future<void> fetchMachines() async {
    final response = await supabase.from('machines').select();
    List<Machine> machineData = [];
    for (var row in response) {
      final queue = await supabase
          .from('waitingqueue')
          .select()
          .eq('machine_id', row['machine_id']);
      machineData.add(
        Machine(
          id: row['machine_id'] as int,
          name: row['name'] as String,
          muscleGroup: row['muscle_group'] as String,
          status: row['status'] as String,
          capacity: queue.length,
        ),
      );
    }
    setState(() {
      machines = machineData;
    });
    fetchSelectedMachines();
  }

  void fetchSelectedMachines() {
    List<Machine> machineData = [];
    for (var machine in machines) {
      if (machine.muscleGroup.toLowerCase() ==
          muscleGroups[_selectedIndex].toLowerCase()) {
        machineData.add(machine);
      }
    }
    setState(() {
      selectedMachines = machineData;
    });
  }

  void subscribeToMachineChanges() {
    supabase.from('machines').stream(primaryKey: ['machine_id']).listen((
      event,
    ) {
      fetchCapacityData();
    });
  }

  void subscribeToQueueChanges() {
    supabase.from('waitingqueue').stream(primaryKey: ['queue_id']).listen((
      event,
    ) {
      updateMachineCapacity();
    });
  }

  void updateMachineCapacity() async {
    for (var machine in machines) {
      final queue = await supabase
          .from('waitingqueue')
          .select()
          .eq('machine_id', machine.id);
      machine.capacity = queue.length;
    }
  }

  Future<void> fetchCapacityData() async {
    try {
      final peopleResponse = await supabase
          .from('machines')
          .select('machine_id')
          .eq('status', 'occupied');
      final machinesResponse = await supabase
          .from('machines')
          .select('machine_id');

      if (peopleResponse.isEmpty || machinesResponse.isEmpty) {
        return;
      }

      int peopleCount = peopleResponse.length; // Defaults to 0 if null
      int machinesCount = machinesResponse.length; // Prevent division by zero

      print('Updating capacity ratio: $peopleCount / $machinesCount');

      setState(() {
        capacityRatio = (peopleCount / machinesCount);
      });
    } catch (e) {
      print("Error fetching capacity data: $e");
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
              // Capacity Indicator
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularPercentIndicator(
                        // animation: true,
                        // animationDuration: 1000,
                        radius: 70,
                        lineWidth: 10,
                        percent: capacityRatio,
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
                            '${(capacityRatio * 100).toInt()}%',
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
                            (capacityRatio * 100).toInt() > 90
                                ? 'The gym is almost at full capacity!'
                                : (capacityRatio * 100).toInt() > 70
                                ? 'The gym is getting busy!'
                                : 'The gym is not too busy!',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Muscle Group Selectors
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Enables horizontal scrolling
                child: Row(
                  children: List.generate(8, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap:
                            () => {
                              setState(() {
                                _selectedIndex = index;
                                fetchSelectedMachines();
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
            // Machine Cards
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: selectedMachines.length,
                itemBuilder: (context, index) {
                  final machine = selectedMachines[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.5 - 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.offblack,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  machine.name,
                                  style: TextStyle(
                                    fontFamily: 'Polymath',
                                    fontSize: 16,
                                    fontVariations: [
                                      FontVariation('wght', 600),
                                    ],
                                    color: AppColors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/${machine.name.trim().toLowerCase().replaceAll(' ', '-')}.png',
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.person,
                                    size: 15,
                                    color: AppColors.white.withOpacity(0.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      machine.capacity.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                  minimumSize: WidgetStateProperty.all(
                                    Size(25, 25),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    AppColors.periwinkle,
                                  ),
                                  shape: WidgetStateProperty.all(
                                    CircleBorder(),
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    final user = supabase.auth.currentUser;
                                    if (user == null) {
                                      return;
                                    }
                                    // Step 1: Check if the user is already in the queue
                                    final existingQueueResponse =
                                        await supabase
                                            .from('waitingqueue')
                                            .select('machine_id')
                                            .eq('user_id', user.id)
                                            .maybeSingle(); // Get a single row if it exists

                                    if (existingQueueResponse != null) {
                                      print(
                                        "User is already in queue for ${existingQueueResponse['machine_name']}",
                                      );
                                      return; // Prevent adding another entry
                                    }
                                    await supabase.from('waitingqueue').insert({
                                      'machine_id': machine.id,
                                      'user_id': user.id,
                                      'joined_queue':
                                          DateTime.now().toIso8601String(),
                                    });
                                  } catch (e) {
                                    print("Error joining queue: $e");
                                  }
                                },
                                child: Icon(Icons.add, size: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
