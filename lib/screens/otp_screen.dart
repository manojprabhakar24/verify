import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'mainscreen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String? otpCode;


  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == true
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      )
          : Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: PinCodeTextField(
                autoDisposeControllers: false,
                appContext: context,
                length: 6,
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,

              ),
            ),
          ),

        ],
      ),
    );
  }



  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(name: '', phoneNumber: '')),
              (route) => false,
        );
      },
    );
  }
}
