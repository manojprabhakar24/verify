
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
      apiKey: 'AIzaSyDqA85YF2z4qRmZgw6pzGDSC67rG3TyOVE',
      appId: "1:393909240919:android:8a7bf6560e681049628f12",
      messagingSenderId: "393909240919",
      projectId: "flutter-login-6480f",
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
        home: const SignInScreen(),
      ),
    );
  }
}


