import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/core/utils/styles.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../generated/l10n.dart';
import '../cubit/login_cubit.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            debugPrint('LoginState: $state');
            return Column(
              children: [
                SizedBox(height: deviceHeight * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhiteColor,
                        size: 30,
                      ),
                    ),
                    Text(
                      S.of(context).login,
                      style: Styles.textStyle30.copyWith(
                        color: AppColors.kWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.02),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.18),
                            child: Text(
                              S.of(context).lets_login,
                              style: Styles.textStyle30.copyWith(
                                color: AppColors.kBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (state is LoginErrorState) ...[
                            if (state.errorMessage != null)
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.info_outline,
                                    color: AppColors.kRedColor,
                                  ),
                                  Text(
                                    state.errorMessage!,
                                    style: Styles.textStyle16.copyWith(
                                      color: AppColors.kRedColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            if (state.validationErrors != null) ...[
                              if (state.validationErrors!.containsKey('phone'))
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    const Icon(
                                      Icons.info_outline,
                                      color: AppColors.kRedColor,
                                    ),
                                    Text(
                                      state.validationErrors!['phone']!.first,
                                      style: Styles.textStyle16.copyWith(
                                        color: AppColors.kRedColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              if (state.validationErrors!.containsKey('password'))
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    const Icon(
                                      Icons.info_outline,
                                      color: AppColors.kRedColor,
                                    ),
                                    Text(
                                      state.validationErrors!['password']!.first,
                                      style: Styles.textStyle16.copyWith(
                                        color: AppColors.kRedColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ],
                          const SizedBox(height: 35),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).phone,
                                  style: Styles.textStyle18.copyWith(
                                    color: AppColors.kGreyShade,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(passwordFocusNode);
                              },
                              controller: phoneController,
                              style: Styles.textStyle16.copyWith(color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kGreyShade, width: 1)),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kGreyShade, width: 1)),
                                hintText: '05########',
                                hintStyle: Styles.textStyle16.copyWith(color: AppColors.kGreyShade, fontWeight: FontWeight.bold),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).enter_phone_number;
                                }
                                return null;
                              },
                              onSaved: (val) {},
                            ),
                          ),
                          const SizedBox(height: 35),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).password,
                                  style: Styles.textStyle18.copyWith(
                                    color: AppColors.kGreyShade,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                              focusNode: passwordFocusNode,
                              obscureText: BlocProvider.of<LoginCubit>(context).obscurePassword,
                              controller: passwordController,
                              style: Styles.textStyle16.copyWith(color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kGreyShade, width: 1)),
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kGreyShade, width: 1)),
                                suffixIcon: IconButton(
                                  onPressed: () => BlocProvider.of<LoginCubit>(context).changePasswordVisibility(),
                                  icon: Icon(BlocProvider.of<LoginCubit>(context).obscurePassword ? Icons.visibility_off : Icons.visibility),
                                ),
                                hintText: BlocProvider.of<LoginCubit>(context).obscurePassword ? '  ****************' : ' 123456789',
                                hintStyle: Styles.textStyle16.copyWith(color: AppColors.kGreyShade, fontWeight: FontWeight.bold),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).please_enter_password;
                                }
                                return null;
                              },
                              onSaved: (val) {},
                            ),
                          ),
                          SizedBox(height: deviceHeight * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  S.of(context).forgot_password,
                                  style: Styles.textStyle18.copyWith(color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: deviceHeight * 0.02),
                          state is LoginLoadingState
                              ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomLoadingIndicator(),
                            ],
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context).login(
                                    phone: phoneController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: deviceWidth * 0.45,
                                    minHeight: deviceHeight * 0.06,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    S.of(context).login,
                                    textAlign: TextAlign.center,
                                    style: Styles.textStyle18.copyWith(
                                      color: AppColors.kWhiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: deviceHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).dont_have_account,
                                style: Styles.textStyle18.copyWith(color: AppColors.kGreyShade, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  S.of(context).register,
                                  style: Styles.textStyle18.copyWith(color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

