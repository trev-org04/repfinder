import 'package:flutter/material.dart';
import 'package:repfinder/home/home.dart';
import 'package:repfinder/onboarding/onboarding.dart';
import 'package:repfinder/onboarding/sign_in.dart';
import 'package:repfinder/onboarding/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '/Users/kathirmaari/Projects/personal_projects/hackai_2025/repfinder/repfinder/assets/.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    debug: true,
  );

  runApp(const Repfinder());
}

final supabase = Supabase.instance.client;

class Repfinder extends StatelessWidget {
  const Repfinder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Onboarding(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomePage(),
      },
      title: 'Rep Finder',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: AppColors.black,
          primary: AppColors.white,
        ),
      ),
    );
  }
}
