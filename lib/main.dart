
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:verify/providers/auth_provider.dart';
import 'constant/theme.dart';
import 'screens/welcome_screen.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCje9NG6b5US0pNQTe7DqjionSVjjY13GQ',
      appId: "1:364495328134:android:2b1e420a2d7be6215f9207",
      messagingSenderId: "364495328134",
      projectId: "phone-otp-8d816",
    ),
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme, // Use your defined appTheme here
        home: SignInScreen(),
      ),
    );
  }
}


