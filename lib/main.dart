import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumitrecordingsapp/globals.dart';
import 'package:sumitrecordingsapp/months_page.dart';
import 'package:sumitrecordingsapp/onboarding_screen.dart';
import 'package:sumitrecordingsapp/providers/meeting_provider.dart';
import 'package:sumitrecordingsapp/screens/home_page.dart';
import 'package:sumitrecordingsapp/screens/new_meeting.dart';
import 'package:sumitrecordingsapp/test/MeetingHive.dart';
import 'package:sumitrecordingsapp/test1/AccountHive.dart';
import 'package:uuid/uuid.dart';

late Box<MeetingHive> boxMeetings;
late Box<AccountHive> boxAccounts;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(AccountHiveAdapter());
  Hive.registerAdapter(MeetingHiveAdapter());
  boxMeetings = await Hive.openBox<MeetingHive>('meetingBoxA');
  boxAccounts = await Hive.openBox<AccountHive>('accountBox');
  boxAccounts.put(
    1,
    AccountHive(firstName: 'Amir', isFirstLogin: true, lastName: 'Waisblay'),
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SumitShift',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.orange),
      ),

      home: ProviderScope(child: MyHomePage()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (boxAccounts.values.first.isFirstLogin) {
      return OnboardingScreen();
    }
    return Scaffold(
      floatingActionButton: NewMeeting(),
      backgroundColor: GlobalColors.background,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Months',
          ),
        ],
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('SumitShift'),
      ),

      body: switch (currentPageIndex) {
        0 => HomePage(),
        1 => MonthsPage(),
        _ => Text('data'),
      },
    );
  }
}
