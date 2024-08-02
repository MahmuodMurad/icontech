import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/utils/app_colors.dart';
import 'login_screen.dart';

class VerifyPasswordScreen extends StatelessWidget {
  const VerifyPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: deviceHeight * 0.14,
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: const Text(
                  "Back to Login",
                  style: TextStyle(color: Colors.white,fontFamily: 'Roboto',),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "Verify Password",
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 29,
                          shadows: <Shadow>[
                            Shadow(
                              blurRadius: 2.0,
                              offset: Offset(0, 4),
                              color: Color.fromARGB(50, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(""),
                    ),
                     const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Enter the verification code we just sent you\non your email address',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: PinTheme(
                            decoration: BoxDecoration(
                              border: Border.all(color:  AppColors.kPrimaryColor),
                            ),
                            width: 50,
                            height: 50),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const VerifyPasswordScreen(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kPrimaryColor,
                                AppColors.kPrimaryColor.withOpacity(0.5)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: deviceWidth * 8 / 10,
                              minHeight: 50.0,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Verify",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
