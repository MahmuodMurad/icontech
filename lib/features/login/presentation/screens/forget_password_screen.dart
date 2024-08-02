import 'package:flutter/material.dart';
import 'package:icontech/features/login/presentation/screens/login_screen.dart';
import 'package:icontech/features/login/presentation/screens/verify_screen.dart';

import '../../../../core/utils/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

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
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Roboto'),
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
                     Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 29,
                          shadows: const <Shadow>[
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
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Enter the registered Email Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 18,
                            ),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'We will Email you a code to reset your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: emailController,
                        style:  TextStyle(
                          color: AppColors.kPrimaryColor,
                        ),
                        decoration:  InputDecoration(
                          focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kPrimaryColor,width: 2)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kPrimaryColor,width: 2)),
                          hintText: '  Enter your Email',
                          hintStyle: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Email';
                          }
                          // if (!emailRegExp.hasMatch(value)) {
                          //   return 'Please enter valid email format';
                          // }
                          return null;
                        },
                        onSaved: (val) {},
                      ),
                    ),
                    const SizedBox(height: 60),
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
                                AppColors.kPrimaryColor.withOpacity(0.5),
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
                              "Send",
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
