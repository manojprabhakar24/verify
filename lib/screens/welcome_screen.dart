import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verify/screens/mainscreen.dart';

import '../constant/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '+91');
  final TextEditingController otpController = TextEditingController();
  late String _verificationId;
  bool isNameValid = false;
  bool otpRequested = false;
  bool showOTPField = false;

  Future<void> _getOtp() async {
    final phoneNumber = '+${phoneController.text.trim()}';
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            otpRequested = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _verifyOtp() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            name: nameController.text.trim(),
            phoneNumber: phoneController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(validateName);
  }

  void validateName() {
    setState(() {
      isNameValid = nameController.text.trim().length >= 3;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(validateName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 200,
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/Scissorsimage-logo.png',
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Scissor\'s',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        TextField(
                          style: Theme.of(context).textTheme.labelLarge,
                          controller: nameController,
                          maxLength: 30,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration( labelText: 'Enter your Name',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(color: appTheme.colorScheme.primary),
                            prefixIcon: Icon(Icons.person, color:appTheme.colorScheme.primary),
                            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appTheme.colorScheme.primary, width: 1.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appTheme.colorScheme.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                          ),
                  ),

                        const SizedBox(height: 10),
                        TextField(
                          style: Theme.of(context).textTheme.labelLarge,
                          controller: phoneController,
                          maxLength: 15,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Enter your Mobile Number',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(color: appTheme.colorScheme.primary),
                            prefixIcon: Icon(Icons.phone, color: appTheme.colorScheme.primary),
                            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appTheme.colorScheme.primary, width: 1.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:appTheme.colorScheme.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5),
                          ),

                        ),

                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.brown; // Disabled color
                                } else if (states.contains(MaterialState.pressed)) {
                                  return Colors.brown[200]!; // Pressed color
                                } else {
                                  return Colors.brown[400]!; // Enabled color
                                }
                              },
                            ),
                          ),
                          onPressed: isNameValid ? () => _getOtp() : null,
                          child: Text(
                            otpRequested ? 'Resend OTP' : 'Get OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        if (otpRequested) ...[
                          const SizedBox(height: 20),
                          TextField(
                            style: Theme.of(context).textTheme.labelLarge,
                            controller: otpController,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelStyle: TextStyle(color:appTheme.colorScheme.primary),
                              prefixIcon: Icon(Icons.message_sharp, color: appTheme.colorScheme.primary),
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appTheme.colorScheme.primary, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:appTheme.colorScheme.primary, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                            ),

                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _verifyOtp,
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
